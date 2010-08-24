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
    sh "curl -0 http://rdf.dmoz.org/rdf/content.rdf.u8.gz > #{DMOZ_FILE}"
  end

  file DMOZ_FILE => [DMOZ_FILE_GZ] do
    sh "cd #{DMOZ_DIR} && gunzip #{DMOZ_FILE_GZ}"
  end

  desc "extract the urls from the dmoz file"
  task :extract_urls do
    sh %Q{cat #{DMOZ_FILE}  | grep http | grep r:resource | grep -o '<link r:resource=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<link r:resource=["'"'"']//' -e 's/["'"'"']$//' > #{URLS_FILE}}
  end

  desc "extract random urls from the url file"
  task :extract_random_urls do
    sh "./bin/random-lines.sh #{URLS_FILE} 100 > #{RND_URLS_FILE}"
  end

end

PAGE_COUNTS_FILE="data/page-counts.txt"

namespace :crawl do
  desc "clean the crawl results"
  task :clean do
    sh "rm -rf data/pages"
    sh "rm data/page-counts.txt"
  end
  desc "record and watch the results"
  task :watch do
    sh %Q{watch -n 1 'echo $(date +%s) $(find data/pages -type f | wc -l) | tee -a #{PAGE_COUNTS_FILE}'}
  end
  desc "run the crawl"
  task :run do
    sh %Q{./bin/crawl.sh #{RND_URLS_FILE} | tee -a log/crawl.log}
  end
end

namespace :results do
  desc "make results relative"
  task "make_relative" do
    mkdir_p "log/results" rescue nil
    relative_file = "log/results/page-counts-#{Time.now.strftime("%Y-%m-%d-%H.%M.%S")}.csv"
    sh "ruby bin/process-page-numbers.rb #{PAGE_COUNTS_FILE} > #{relative_file}"
  end
end

# 
# pages <- read.csv("log/results/page-counts-2010-08-24-11.53.24.txt", head=FALSE)
# summary(pages$V2)


