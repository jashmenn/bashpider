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
    sh "./bin/random-lines.sh #{URLS_FILE} 10 > #{RND_URLS_FILE}"
  end

end

namespace :crawl do
  desc "clean the crawl results"
  task :clean do
    sh "rm -rf data/pages"
    sh "rm data/page-counts.txt"
  end
  desc "record and watch the results"
  task :watch do
    sh %Q{watch -n 1 'echo $(date +%s) $(ls -1 | wc -l) | tee -a data/page-counts.txt'}
  end
end


