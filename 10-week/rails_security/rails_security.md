Watch this video about CSRF:

- https://www.youtube.com/watch?v=vRBihr41JTo


Watch this video about XSS:

- https://www.youtube.com/watch?v=L5l9lSnNMxg


------

# WDI Web Security: Part One

Today, we will examine modern issues in web security.

## Objectives

- Read and understand two recent articles about web security.
- Understand how GET/POST and HTML forms work.
- Write HTTParty Ruby code that brute forces user enumeration, email enumeration, and log ins.


## How to Play

Here is the app we will be attacking: [https://securityone.herokuapp.com](https://securityone.herokuapp.com/). This app uses the standard authentication procedures we have been using in class. However, the authentication tokens were disabled, which allows users to make GET/POST requests without coming from another page in the app!

Using the techniques described in the following two recent articles, attempt to log in as an administrator:

- [User Enumeration @ LizardStresser.us](http://www.ericzhang.me/lizardstresser-user-enumeration/)
- [Invalid Username/Password Worthless](https://kev.inburke.com/kevin/invalid-username-or-password-useless/)


Your strategy will be:

1. Find a way to enumerate all usernames.
2. For each username, find the associated email.
3. Brute force each email against top passwords. Three user accounts are using easy passwords. One of the three is an administrator!


The potential passwords are:

- test
- password
- 123456789
- iloveyou
- letmein
- 111111
- admin
- passw0rd


Example HTTParty GET:

``` 
HTTParty.get('https://securityone.herokuapp.com?username=dan')

```

Example HTTParty POST:

``` 
HTTParty.post('https://securityone.herokuapp.com', :body => {'username' => 'dan'})

```

**In a web form, if the parameter is formname[email], then in HTTParty you will use in the POST section: 'formname[email]' => 'test@test.com'.**

## Tips

- You will know you logged in when the body HTML text does not contain the log in form!
- You will know you have logged in as an administrator when the body HTML text contains: Congratulations -- YOU ARE ADMIN!
- Attempt to enumerate usernames and emails using a plain Ruby file (no Rails). To do this, you should: require 'httparty'.
- Find a list of common passwords online, and use these to attempt logging in with all emails discovered.
- The two HTTParty commands you will use are HTTParty.get and HTTParty.post.
