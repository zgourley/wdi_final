#Using CarrierWave: Basics

This is Part One of a three part series:

+ [Part I - Basic CarrierWave](./README.md)
+ [Part II - Figaro Gem - Rails Key Security Best Practices](./rails-security-figaro.md)
+ [Part III - CarrierWave w/ Amazon S3](./carrierwave-amazon-s3.md)

How can you figure this out on your own?

+ [CarrierWave documentation](https://github.com/carrierwaveuploader/carrierwave)

In the following steps, we will create a file field called :image which uses the CarrierWave class 'AvatarUploader', since it is specifically an image of the user's avatar.

1. **Add gems.** Add to the top of your Gemfile, then `bundle install`:

```ruby
		##### CarrierWave Gems #####
		gem 'carrierwave'

		gem 'fog'         # required for Amazon S3
		gem 'rmagick'     # for post-upload image processing
```

2. **Create a new uploader class.** Run:

		`rails g uploader Avatar`

	This creates a file which defines the class AvatarUploader: `app/uploaders/avatar_uploader.rb`


3. **Make a file field in your model.** Inside your User model underneath the fields, make a new file field:

```ruby
		mount_uploader :image, AvatarUploader
```

	Note that the field name (:image) does NOT have to be identical to the name of the uploader.

4. **Add the form field to your HTML.**  In your HTML new view:

```erb
		<%= f.file_field :image %>
```

5. **Add the image parameter to the strong params in your controller.** In your user controller:

```ruby
		params.require(:user).permit(..., :image)
```
 
6. **Display the uploaded images!** In your HTML index view:

```erb
		<%= image_tag u.image.url %>
```
----

##Resizing Uploads

+ In the AvatarUploader class `app/uploaders/avatar_uploader.rb`, include rmagick:

```ruby
		include CarrierWave::RMagick
```

+ In the AvatarUploader class `app/uploaders/avatar_uploader.rb`, insert (or just uncomment):

```ruby
		version :thumb do
			process :resize_to_fit => [32, 32]
		end

		version :full do
			process :resize_to_fit => [1024, 768]
		end
```

+ In the view, we can refer to these new versions as follows:

```erb
		<%= image_tag u.image.url(:thumb) %>
```
----

+ CarrierWave can do a lot more. For example, it supports an easy way for users to type in a URL and have CarrierWave auto-grab the image from the URL then save it on S3! 

+ For this and more cool tricks, read the documentation:
	+ [CarrierWave documentation](https://github.com/carrierwaveuploader/carrierwave)
	+ [Cool screencast](https://gorails.com/episodes/file-uploading-with-carrierwave)
