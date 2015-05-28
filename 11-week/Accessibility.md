#Accessibility


> The power of the Web is in its universality.
Access by everyone regardless of disability is an essential aspect ~ Tim Berners-Lee

As a **blind user**, when I **hit your website** I want to **have access to all the content** so that I can **be like everybody else**

----

Millions of people have disabilities that affect their use of the Web. Currently most Web sites and Web software have accessibility barriers that make it difficult or impossible for many people with disabilities to use the Web. As more accessible Web sites and software become available, people with disabilities are able to use and contribute to the Web more effectively

For certain organizations, accessibility of their product might be required by law. For others, it is a core part of their business. 

It is important to consider accessibility from the inception of your project. 

Considering accessibility will always improve your design (Simplicity)


##Screen Readers

iOs voice over: Settings>General>Accessibility>Voice over

OSX voice over command + F5

browser extensions:

* [firefox](https://addons.mozilla.org/en-us/firefox/addon/fangs-screen-reader-emulator/)

* [chrome](https://chrome.google.com/webstore/detail/chromevox/kgejglhpjiefppelpmljglcjbhoiplfn?hl=en)


##Examples of accessibility



####[Alt tags](http://www.w3schools.com/tags/att_img_alt.asp) for images

Using alt tags will allow screen readers to provide information to the user about the content of the image:

* [http://webaim.org/techniques/alttext/](http://webaim.org/techniques/alttext/)

* [http://www.phase2technology.com/blog/no-more-excuses-the-definitive-guide-to-the-alt-text-field/](http://www.phase2technology.com/blog/no-more-excuses-the-definitive-guide-to-the-alt-text-field/)

####[ng-Aria](https://docs.angularjs.org/api/ngAria) 
The ngAria module provides support for common ARIA attributes that convey state or semantic information about the application for users of assistive technologies, such as screen readers.

For ngAria to do its magic, simply include the module as a dependency. The directives supported by ngAria are: ngModel, ngDisabled, ngShow, ngHide, ngClick, ngDblClick, and ngMessages.


####Keyboard input
Some people cannot use a mouse, including many users with limited fine motor control. An accessible website does not rely on the mouse; it provides all functionality via a keyboard as an alternative. 

####[Audio Transcription](https://chrome.google.com/webstore/detail/transcribe-transcribe-aud/ogokenmicnjdfhmhocanoemnddmpcjjm?hl=en-US) 

The opposite of screen readers.... 

####Accessibility in Rails

[capybara-accessible](http://blog.pivotal.io/labs/labs/automated-accessibility-testing-rails)

[raakt](http://www.standards-schmandards.com/projects/raakt/)





