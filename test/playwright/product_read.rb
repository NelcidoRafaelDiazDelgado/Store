require "playwright"

Playwright.create(playwright_cli_executable_path: "npx playwright") do |playwright|
  browser = playwright.chromium.launch(headless: true)
  page = browser.new_page
  page.goto("http://localhost:3000/products")

  rows = page.locator("table tbody tr")
  puts rows.count
  puts rows.first.text_content
end
