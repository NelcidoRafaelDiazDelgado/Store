require "playwright"

id = rand(1..100)

Playwright.create(playwright_cli_executable_path: "npx playwright") do |playwright|
  browser = playwright.chromium.launch(headless: true)
  page = browser.new_page
  page.goto("http://localhost:3000/products/#{id}")

  page.click("text=Edit") # o selector del link edit

  page.fill("input[name='product[price]']", "999")
  page.click("input[type='submit']")
end
