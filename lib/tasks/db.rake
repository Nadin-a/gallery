namespace :db do
  desc 'From folder to db'
  task :fill_db => :environment do
    categories = Dir.entries('/home/trofimova/gallery content').reject { |f| File.directory? f }
    rand = Random.rand(1..3)
    categories.each do |category_name|
      c = Category.new
      c.name = category_name
      c.owner_id = Random.rand(1..3)
      c.save!
      category = Category.first

      images = Dir.entries('/home/trofimova/gallery content/' + category_name).reject { |f| File.file? f }

      images.each do |image_title|
        next if image_title == '.' || image_title == '..'
        i = Image.new
        i.title = image_title.sub(/\.[^.]+\z/, '')
        i.picture = File.open('/home/trofimova/gallery content/' + category_name + '/' + image_title)
        i.description = ''
        i.category_id = category.id
        i.save!
      end
      category.update_attribute(:cover, category.images.sample.picture)
    end
  end
end
