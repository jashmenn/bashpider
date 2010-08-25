namespace :data do

  DMOZ_DIR = "data/dmoz"
  DMOZ_FILE = DMOZ_DIR + "/dmoz-content.rdf.u8" 
  DMOZ_FILE_GZ = DMOZ_FILE + ".gz" 
  URLS_FILE = DMOZ_DIR + "/urls.txt"
  RND_URLS_FILE = DMOZ_DIR + "/random-urls.txt"

  desc "download dmoz index"
  task :dmoz => [DMOZ_FILE] do
  end

  directory DMOZ_DIR do
    mkdir_p DMOZ_DIR rescue nil
  end

  file DMOZ_FILE_GZ => [DMOZ_DIR] do
    sh "curl -0 http://rdf.dmoz.org/rdf/content.rdf.u8.gz > #{DMOZ_FILE_GZ}"
  end

  file DMOZ_FILE => [DMOZ_FILE_GZ] do
    sh "cd #{DMOZ_DIR} && gunzip #{File.basename(DMOZ_FILE_GZ)}"
  end

  file URLS_FILE => [DMOZ_FILE] do
    sh %Q{cat #{DMOZ_FILE}  | grep http | grep r:resource | grep -o '<link r:resource=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<link r:resource=["'"'"']//' -e 's/["'"'"']$//' > #{URLS_FILE}}
  end

  desc "create the urls file"
  task :get_urls => [URLS_FILE]

  desc "extract random urls from the url file"
  task :extract_random_urls do
    sh "ruby ./bin/random-lines.rb #{URLS_FILE} 100000 > #{RND_URLS_FILE}"
  end

end

PAGE_COUNTS_FILE="data/page-counts.txt"

namespace :crawl do
  desc "clean the crawl results"
  task :clean do
    sh "rm -rf data/pages" rescue nil
    sh "rm data/page-counts.txt" rescue nil
  end
  desc "record and watch the results"
  task :watch do
    sh %Q{watch -n 1 'echo $(date +%s) $(find data/pages -type f | wc -l) | tee -a #{PAGE_COUNTS_FILE}'}
  end
  desc "run the crawl"
  task :run do
    num_crawlers = ENV["NUM_CRAWLERS"] || 10
    sh "mkdir -p log"
    sh %Q{./bin/crawl.sh #{RND_URLS_FILE} #{num_crawlers} | tee -a log/crawl.log}
  end

  desc "start a new crawl"
  task :restart => ["crawl:clean", "data:extract_random_urls", "crawl:run"]
end

namespace :results do
  desc "process results"
  task :process => ["make_relative"]

  desc "make results relative"
  task "make_relative" do
    mkdir_p "log/results" rescue nil
    relative_file = "log/results/page-counts-#{Time.now.strftime("%Y-%m-%d-%H.%M.%S")}.csv"
    sh "ruby bin/process-page-numbers.rb #{PAGE_COUNTS_FILE} > #{relative_file}"
    sh "ruby bin/find-pages-per-second.rb #{relative_file}"

end
