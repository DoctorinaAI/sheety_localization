# ==============================================================================
# Stage 1: Build AOT-compiled binaries
# ==============================================================================
FROM dart:stable AS build

WORKDIR /app

# Cache dependencies
COPY pubspec.yaml ./
RUN dart pub get --no-example

# Copy source and compile
COPY bin/ bin/
RUN dart compile exe bin/generate.dart -o /app/bin/generate && \
    dart compile exe bin/localize.dart  -o /app/bin/localize

# Collect runtime dependencies (glibc, ld-linux, etc.)
RUN mkdir -p /runtime/lib /runtime/lib64 && \
    # Use ldd to find all shared libraries needed by compiled binaries
    (ldd /app/bin/generate /app/bin/localize || true) \
      | grep -oP '(?<==> )\S+' | sort -u | while read lib; do \
        dir="/runtime$(dirname "$lib")"; \
        mkdir -p "$dir"; \
        cp "$lib" "$dir/"; \
      done && \
    # Copy the dynamic linker
    cp /lib64/ld-linux-* /runtime/lib64/ 2>/dev/null || \
    cp /lib/ld-linux-* /runtime/lib/ 2>/dev/null || true

# ==============================================================================
# Stage 2: Minimal scratch image
# ==============================================================================
FROM scratch

# CA certificates for HTTPS (Google Sheets API, OpenAI API)
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt

# Runtime libraries (glibc, ld-linux)
COPY --from=build /runtime/ /

# Compiled binaries
COPY --from=build /app/bin/generate /bin/generate
COPY --from=build /app/bin/localize /bin/localize

ENTRYPOINT ["/bin/generate"]
