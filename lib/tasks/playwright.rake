namespace :playwright do
  desc "Run all Playwright Ruby tests"
  task run: :environment do
    Dir.glob("test/playwright/**/*.rb").each do |file|
      puts "\n🚀 Running: #{file}"
      system("ruby #{file}")

      puts "✅ Finished: #{file}\n"
    end
  end
end
