/// A1 notation of sheet ranges, shared by `localize` and `generate`.
library;

/// The A1 range of the whole sheet titled [title].
///
/// The title is always quoted and its apostrophes doubled: an unquoted title
/// with spaces, or one that looks like a cell reference (`v2`, `web1`,
/// `ios16`, `A1`), is not the sheet it names — the API reads that cell of
/// the first sheet instead.
String sheetRange(String title) => "'${title.replaceAll("'", "''")}'";
