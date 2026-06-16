require "playwright"

Playwright.create(playwright_cli_executable_path: "npx playwright") do |playwright|
  browser = playwright.chromium.launch(headless: true)
  page = browser.new_page

  page.goto("http://localhost:3000/products/new")

  page.fill("input[name='product[name]']", "Laptop")
  page.fill("textarea[name='product[description]']", "Gaming laptop")
  page.fill("input[name='product[price]']", "1200")
  page.fill("input[name='product[sku]']", "123-abc")
  page.fill("input[name='product[amount]']", "10")
  page.fill("input[name='product[minimum]']", "1")
  page.fill("input[name='product[status]']", "active")

  page.click("input[type='submit']")

  page.wait_for_timeout(2000)

  browser.close
end
