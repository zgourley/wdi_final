#CarrierWave w/ Amazon S3

This is Part Three of a three part series:

+ [Part I - Basic CarrierWave](./README.md)
+ [Part II - Figaro Gem - Rails Key Security Best Practices](./rails-security-figaro.md)
+ [Part III - CarrierWave w/ Amazon S3](./carrierwave-amazon-s3.md)

Heroku only allows temporary file storage. So, to store uploaded files we will need to create an account elsewhere. Amazon has a free tier that allows up to 5GB storage for a year.* 

* GA provides $250 in Amazon AWS credits. Signing up for the Free Tier now will not affect your eligibility for the Amazon credits. [Go here to request the $250 account credit.](http://aws.amazon.com/activate/event/gafrontrow/)

##Create the Bucket

+ Log in to the [Amazon S3 Management Console](https://console.aws.amazon.com/s3/home)

+ Click on Create Bucket and give it a name, in the region of your choice. (Usually, a closer region to your userbase is the best choice.) Click on Create.

##Identity and Access Management (IAM)

+ Click on your name in the upper right bar, then click on [Account Credentials](https://console.aws.amazon.com/iam/home). As Amazon says, "The account credentials provide unlimited access to your AWS resources." So, make sure you safeguard these keys.

+ **Use AWS Identity Management.** In the security popup, it recommends you create users. Click on the IAM Users button. Create a new user. 

+ **Record the user's credentials.** You must not lose the Secret Access Key -- you will not be able to retrieve this later.

+ **Create a Group.** Now, click on Create Group. After naming your group, select the Amazon S3 Full Access policy template. Click Next Step, then Create Group.

+ **Add User to Group.** Click on Users in the left sidebar. Now, click on your new user. In the User summary page, click the button Add User to Groups. Select the group you just created then add the user to that group.

+ **Consider Additional Steps.** Click on your Dashboard -- the uppermost link in the left sidebar. The Security Status section lists additional steps you can take to safeguard your account.

**The key you generated in this step will be the one used for CarrierWave!**

##Billing Alerts

+ It is suggested that you create an alert which notifies you when your account balance exceeds $0.00. To do this, follow [these instructions](http://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/create-billing-alarm.html).

##Amazon Security Credentials Checklist

+ Consider completing the unchecked items on the [Amazon Security Credentials Dashboard](https://console.aws.amazon.com/iam/home).

----

##CarrierWave: Setting up S3

1. The below assumes your sensitive information is stored as environment variables, e.g. using the Figaro gem. In config/application.yml, add your Amazon key and secret key:

		S3_KEY: <key here>
		S3_SECRET: <secret key here>
		S3_BUCKET: <bucket name here>
		S3_REGION: <region name here>

2. **Create S3 configuration file.** Open the directory config/initializers/. Create a new file 'carrierwave.rb' inside. Use the below template, inserting your access key, secret key, [AWS region](http://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region), and your bucket name. 

		CarrierWave.configure do |config|
			config.fog_credentials = {
			    :provider               => 'AWS',            # required
			    :aws_access_key_id      => ENV['S3_KEY'],    # required
			    :aws_secret_access_key  => ENV['S3_SECRET'], # required
			    :region                 => ENV['S3_REGION'], # optional, defaults to 'us-east-1'
			    #:host                  => nil,              # optional, defaults to nil
			    #:endpoint              => nil               # optional, defaults to nil
			}
			
			config.fog_directory   = ENV['S3_BUCKET']     # required
			#config.fog_public     = true          # optional, defaults to true
			#config.fog_attributes = {}            # optional, defaults to {}
		end

3. **Modify uploader to save to S3.** In your AvatarUploader class (app/uploaders/avatar_uploader.r	b), modify the storage from :file to :fog. It will look like:

		# Choose what kind of storage to use for this uploader:
  		# storage :file
  		storage :fog


----

