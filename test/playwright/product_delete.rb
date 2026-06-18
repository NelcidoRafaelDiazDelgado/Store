require "playwright"

id = rand(1..100)

Playwright.create(playwright_cli_executable_path: "npx playwright") do |playwright|
  browser = playwright.chromium.launch(headless: true)
  page = browser.new_page
  page.goto("http://localhost:3000/products/#{id}")

  page.click("text=Delete") # o botón destroy

  page.on("dialog", ->(dialog) { dialog.accept })
end
