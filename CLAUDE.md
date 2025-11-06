# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview
This is a Rails 7.2.1 application that demonstrates Rails 5.1+ features including Assets on Yarn, System tests with Capybara, and the unified form_with method. The app implements a simple Product Hunt-style application with a Product model and CRUD functionality.

## Essential Commands

### Initial Setup
```bash
bin/setup                    # Full setup: install gems, dependencies, prepare database
gem install bundler --conservative
bundle install               # Install Ruby gems
pnpm install                 # Install frontend dependencies (awesomplete, milligram)
brew install chromedriver yarn  # Required for system tests
```

### Running the Application
```bash
bin/rails server             # Start development server on http://localhost:3000
bin/rails console            # Open Rails console
bin/rails restart            # Restart the application server
```

### Database Operations
```bash
bin/rails db:prepare         # Create and migrate database (idempotent)
bin/rails db:create          # Create database
bin/rails db:migrate         # Run migrations
bin/rails db:drop            # Drop database
bin/rails db:seed            # Load seed data
```

### Testing
```bash
bin/rails test               # Run full Minitest suite (models, controllers, integration)
bin/rails test test/system   # Run Capybara system tests (requires chromedriver)
bin/rails test test/models   # Run model tests only
bin/rails test test/controllers  # Run controller tests only
bin/rails test test/integration  # Run integration tests only
```

### Development Tasks
```bash
bin/rails log:clear          # Clear log files
bin/rails tmp:clear          # Clear temporary files
bin/rails assets:precompile  # Precompile assets for production
```

## Architecture & Structure

### Directory Layout
```
/Users/guochunzhong/git/oss/product_hunt
├── app/                     # Rails application code
│   ├── assets/             # Frontend assets (managed by Sprockets)
│   │   ├── javascripts/    # JS files (awesomplete, application.js, cable.js)
│   │   ├── stylesheets/    # SCSS/CSS (milligram.sass, scaffolds.scss)
│   │   └── images/         # Static images
│   ├── channels/           # Action Cable channels
│   ├── controllers/        # Application controllers
│   │   ├── application_controller.rb
│   │   └── products_controller.rb  # CRUD controller for Product model
│   ├── helpers/            # View helpers
│   ├── jobs/               # Background jobs
│   ├── mailers/            # Email templates
│   ├── models/             # Active Record models
│   │   ├── application_record.rb
│   │   └── product.rb      # Main domain model (name, tagline attributes)
│   └── views/              # ERB templates
│       ├── layouts/        # Application layouts
│       └── products/       # Product views (index, show, new, edit, _form)
├── config/                 # Configuration files
│   ├── database.yml        # SQLite database config (dev: storage/development.sqlite3)
│   ├── environments/       # Environment-specific settings
│   └── secrets.yml         # Secret configuration
├── db/                     # Database files
│   ├── migrate/            # Active Record migrations
│   └── schema.rb           # Database schema
├── lib/                    # Shared utilities and code
├── test/                   # Minitest tests
│   ├── fixtures/           # Test data
│   ├── models/             # Model tests
│   ├── controllers/        # Controller tests
│   ├── integration/        # Integration tests
│   ├── system/             # Capybara system tests (new_product_test.rb, products_test.rb)
│   └── helpers/            # Test helpers
├── storage/                # SQLite databases (auto-created)
├── public/                 # Static assets
└── vendor/                 # Third-party code
```

### Core Components

**Models:**
- `Product` (`app/models/product.rb`): Simple Active Record model with name and tagline attributes
- `ApplicationRecord` (`app/models/application_record.rb`): Base model class

**Controllers:**
- `ProductsController` (`app/controllers/products_controller.rb`): Standard RESTful controller with CRUD operations plus `awesomplete_product_name` action for autocomplete functionality
- `ApplicationController` (`app/controllers/application_controller.rb`): Base controller

**Frontend:**
- Uses **Sprockets** for asset pipeline (not Webpacker)
- JavaScript dependencies managed by **pnpm** (not npm/yarn): `awesomplete` (v1.1.7), `milligram` (v1.4.1)
- SCSS stylesheets with Milligram CSS framework
- Awesomplete integration in `app/views/products/awesomplete_product_name.js.erb`

**Testing:**
- Minitest for all test types
- Capybara with Selenium Webdriver for system tests
- Faker (via ffaker gem) for generating test data
- System tests require ChromeDriver (`brew install chromedriver`)

## Database Configuration

- **SQLite3** database for all environments
- Databases stored in `/storage` directory:
  - Development: `storage/development.sqlite3`
  - Test: `storage/test.sqlite3`
  - Production: `storage/production.sqlite3`
- Configuration: `config/database.yml`
- Schema defined in `db/schema.rb`

## Key Dependencies

**Ruby Gems:**
- Rails 7.2.1
- Puma (app server)
- SQLite3 (database adapter)
- SassC-Rails (SCSS compilation)
- Turbolinks
- JBuilder (JSON API generation)
- Capybara + Selenium Webdriver (system testing)
- Bootsnap (performance)
- FFaker (test data generation)
- Terser (JavaScript minification)

**Frontend (pnpm):**
- awesomplete (autocomplete library)
- milligram (CSS framework)

## Development Guidelines

**Code Style:**
- Two-space indentation
- Ruby conventions: `snake_case` for methods/variables, `CamelCase` for classes/modules
- Controller names plural
- Views in `app/views/<resource>/*.html.erb`
- Strong parameters in controllers for security

**Testing Strategy:**
- Add tests in corresponding `test/` subdirectories
- Name test files `<feature>_test.rb`
- System tests use Capybara for browser-based testing
- Use fixtures or explicit builders over factories
- Run full test suite before pushing changes

**Asset Pipeline:**
- JavaScript lives in `app/assets/javascripts`
- Stylesheets in `app/assets/stylesheets`
- Managed by Sprockets, not webpack
- Dependencies in `package.json` installed via pnpm

## CI/CD

CircleCI configuration in `.circleci/config.yml` for automated testing and deployment.

## Common Development Patterns

1. **Creating a new model:**
   ```bash
   bin/rails generate model ModelName field:type
   bin/rails db:migrate
   ```

2. **Running a single test:**
   ```bash
   bin/rails test test/models/product_test.rb
   bin/rails test test/system/products_test.rb
   ```

3. **Checking database state:**
   ```bash
   bin/rails db:console  # SQLite console
   ```

4. **Asset compilation for production:**
   ```bash
   RAILS_ENV=production bin/rails assets:precompile
   ```

## Important Notes

- Requires **chromedriver** for system tests: `brew install chromedriver`
- Frontend package manager is **pnpm**, not npm/yarn
- SQLite databases stored in `/storage/` (not git-tracked)
- No external services required for development
- Environment-specific secrets configured via `config/secrets.yml` or environment variables
- The app demonstrates Rails 5.1+ features and serves as a reference implementation
