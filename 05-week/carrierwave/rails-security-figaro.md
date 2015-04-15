#Rails Secret Key Security w/ Figaro

This is Part Two of a three part series:

+ [Part I - Basic CarrierWave](./README.md)
+ [Part II - Figaro Gem - Rails Key Security Best Practices](./rails-security-figaro.md)
+ [Part III - CarrierWave w/ Amazon S3](./carrierwave-amazon-s3.md)
	
Why is it important to keep your API keys secret from Github?

+ [My $2375 Amazon EC2 Mistake](http://www.devfactor.net/2014/12/30/2375-amazon-mistake/). Need more [anecdotal evidence](https://news.ycombinator.com/item?id=8818035)?
	
#Figaro

Figaro is a Ruby gem which secures your secret keys on Rails. It prevents them from being uploaded to Github, and it makes it easy to make them environment variables -- both locally and on Heroku. Read the [documentation for Figaro](https://github.com/laserlemon/figaro) for exact usage details. 

+ **Add Figaro to Gemfile**. To your Gemfile, add:

		gem "figaro"

	Then run:
	
		bundle install
		
+ **Install Figaro**. From within your Rails app directory, run:

		figaro install

	"This creates a commented config/application.yml file and adds it to your .gitignore. Add your own configuration to this file and you're done!" **Verify that .gitignore exists in the root of your app! Your .gitignore file must include 'config/application.yml'!**

+ In config/application.yml, add your Amazon key and secret key:

		S3_KEY: <key here>
		S3_SECRET: <secret key here>
		S3_BUCKET: <bucket name here>
		S3_REGION: <region name here>

+ Now, in your configuration file, /config/initializers/carrierwave.rb, update your keys from plaintext strings to ENV['amazon_user_key_id'] and ENV['amazon_user_secret_key'] as follows -- **DO NOT COMMENT OUT THE OLD VERSION -- DELETE IT**:

		
		:aws_access_key_id      => ENV['S3_KEY'],     # required
		:aws_secret_access_key  => ENV['S3_SECRET'],  # required
		:region                 => ENV['S3_REGION'],
		...
		:config.fog_directory =  ENV['S3_BUCKET']     # required
		
	
+ **Heroku Deployment.** When you deploy to Heroku, you must use a special command to set the Figaro keys as environment variables. Read the [documentation for Figaro](https://github.com/laserlemon/figaro).

+ You will need to manually send this application.yml file to contributors.
	
#Did You Accidentally Publish Keys to GitHub?

+ GitHub: "Danger: Once you have pushed a commit to GitHub, you should consider any data it contains to be compromised."

+ Because of this, **you must immediately invalidate your server-side keys if you accidentally upload them to GitHub.** See [Why Deleting Sensitive Information from GitHub Does Not Save You](https://jordan-wright.github.io/blog/2014/12/30/why-deleting-sensitive-information-from-github-doesnt-save-you/) to understand how bots can immediately access your keys.

+ After you invalidate your key, [remove it from your GitHub history](https://help.github.com/articles/remove-sensitive-data/).

----

# Preventing Keys from Being Uploaded

+ **Prevention: Always review what you are committing.** Always review the changes you are about to commit before you make the commit. Do not use the -a flag to stage commits! Before each commit, run the following command:

		git diff --cached

+ **Prevention: Use Environment Variables to Store Keys.** Use the Figaro gem with Rails to automatically set up environment variables. Review [My $2375 Amazon EC2 Mistake](http://www.devfactor.net/2014/12/30/2375-amazon-mistake/) and do not make the same mistakes!

