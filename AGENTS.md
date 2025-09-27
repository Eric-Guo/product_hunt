# Repository Guidelines

## Project Structure & Module Organization
This Rails 5.1 app keeps domain logic in `app/` (controllers, models, views, jobs, mailers). Front-end assets and JavaScript live in `app/assets`; shared utilities sit in `lib/`. Tests reside in `test/` alongside fixtures and system specs. Migrations stay under `db/` with the generated schema, configuration belongs in `config/`, static files live in `public/`, and SQLite databases defined in `config/database.yml` are stored in `storage/`.

## Build, Test, and Development Commands
- `bin/setup` installs gems, prepares the SQLite database, and checks prerequisites.
- `yarn install` syncs frontend packages defined in `package.json`.
- `bin/rails server` boots the app locally on `http://localhost:3000`.
- `bin/rails test` runs the full Minitest suite (models, controllers, integration).
- `bin/rails test test/system` executes Capybara system specs; install `chromedriver` beforehand.

## Coding Style & Naming Conventions
Adopt two-space indentation and standard Ruby conventions: `snake_case` for methods and variables, `CamelCase` for classes and modules. Keep controller names plural, place views in `app/views/<resource>/*.html.erb`, and extract shared presentation logic into helpers or partials. JavaScript delivered through Sprockets should remain in `app/assets/javascripts`, and SCSS belongs in `app/assets/stylesheets`. No formatter ships with the project, so keep revisions readable and under roughly 100 characters per line.

## Testing Guidelines
Minitest drives coverage here. Add unit, integration, and system tests in the matching `test/` subdirectories and name files `<feature>_test.rb`. System scenarios should describe user flows clearly and clean up data after assertions. Prefer fixtures or explicit builders over factories to stay consistent with existing tests. Run `bin/rails test` (and the system subset when browser behavior changes) before pushing to ensure new logic and edge cases are covered.

## Commit & Pull Request Guidelines
History favors short, imperative commit subjects (e.g., `gem upgrade`), so start with a verb and keep the summary under ~60 characters. Group related changes logically, and add body context when altering behavior. Pull requests should link issues or tickets, explain the change, and call out migrations or setup steps. Include testing notes (`bin/rails test`, manual checks) and add screenshots or GIFs when UI elements change.

## Environment & Configuration Tips
The default stack uses SQLite databases stored in `storage/`; no external services are required. Keep secrets out of source control—override values from `config/secrets.yml` with environment variables for deployment. Ensure `chromedriver` and `yarn` are installed locally (see `README.md`). Update environment-specific settings in `config/environments/` or relevant initializers when introducing new configuration keys.
