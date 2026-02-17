# Changelog

## [1.1.0] - 2026-02-11

### Added
- Added `faraday ~> 2.0` as explicit runtime dependency
- Added `faraday-multipart >= 1.0` as explicit runtime dependency
- Added `multi_xml >= 0.5` for XML parsing
- Custom XML parser middleware (`ParseXmlMiddleware`) for Faraday 2.x compatibility

### Changed
- Upgraded from Ruby 3.4.5 to Ruby 4.0.1
- Updated vertebrae dependency to >= 1.0.5 for Faraday 2.x compatibility
- Modernized gemspec file with bundler gem tasks