namespace :poll do

  desc "Open 'before' polls"
  task :open => :environment do
  	#puts "Open 'before' polls"
  	Poll.before.each do |poll|
  		if DateTime.now >= poll.start && DateTime.now <= poll.finish
  			poll.status = 1
  			poll.save!
  		end
  	end
  end

  desc "Close 'open' polls"
  task :close => :environment do
  	#puts "Close 'open' polls"
  	Poll.opened.each do |poll|
  		if DateTime.now > poll.finish
  			poll.status = 3
  			poll.save!
  		end
  	end
  end

# Runs only once, when you start 'crono'
  desc "Set all polls statuses"
  task :set => :environment do
  	#puts 'Set all polls statuses'
  	Poll.all.each do |poll|
  		if DateTime.now >= poll.start && DateTime.now <= poll.finish
  			poll.status = 1
  			poll.save!
  		end
  		if DateTime.now < poll.start
  			poll.status = 2
  			poll.save!
  		end
  		if DateTime.now > poll.finish
  			poll.status = 3
  			poll.save!
  		end
  	end
  end

# You can add any rake task inside :all task
  desc "Do all poll tasks"
  task :all => :environment do
  	Rake::Task['poll:set'].invoke
  	Rake::Task['poll:open'].execute
  	Rake::Task['poll:close'].execute
  end
end
