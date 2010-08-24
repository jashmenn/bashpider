namespace :data do

  DMOZ_DIR = "data/dmoz"
  DMOZ_FILE = DMOZ_DIR + "/dmoz-content.rdf.u8.gz" 

  desc "download dmoz index"
  task :dmoz => [DMOZ_FILE] do
  end

  directory DMOZ_DIR do
    mkdir_p DMOZ_DIR rescue nil
  end

  file DMOZ_FILE => [DMOZ_DIR] do
    sh "curl -0 http://rdf.dmoz.org/rdf/content.rdf.u8.gz > #{DMOZ_FILE}"
  end

end
