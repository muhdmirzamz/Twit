## Twitter

A Twitter clone

### Changelog

**19 November 2019 - v0.1.7-alpha.3**
- Fixed autolayout in Profile view
- Changed image picker in profile settings to fullscreen modal presentation style

**18 November 2019 - v0.1.7-alpha.2**
- Changed feed and compose views to a fullscreen modal presentation style

**13 November 2019 - v0.1.7-alpha.1**
- Updated Firebase and syntax

**3 February 2019 - v0.1.7-alpha**
- Profile images show up in your profile page after you upload it

**28 January 2019 - v0.1.6-alpha**
- You can now upload a profile image
- Fixed a crash when switching quickly between the feed and your profile page

**19 January 2019 - v0.1.5-alpha**
- Chronological order is here

**2 January 2019 - v0.1.4-alpha**
- You are now able to tweet something

**29 December 2018 - v0.1.3-alpha.1**
- Added the compose view controller

**28 December 2018 - v0.1.3-alpha**
- Implemented sign in

**23 December 2018 - v0.1.2-alpha**
- Made a sign up screen
- Improved sign up error handling

**21 December 2018 - v0.1.1-alpha.1**
- Implemented sign up checks
- Refactored sign up code

**18 December 2018 - v0.1.1-alpha**
- You can now sign up for the app

**17 December 2018 - v0.1.0-alpha**
- Initial commit
- Initial setup with Firebase done


### INSTALL

This project uses Firebase's real-time database. So it's required that you set up your own Firebase project since it needs a custom Google ```plist``` file. I used the database structure below.

```
root
	Users
		id
			tweet
				tweetid
					timestamp
					tweet_content
```

### Technologies used/Lessons learnt

- Firebase Real-time database
- Cocoapods
- Dealing with time in Swift
- CoreData
