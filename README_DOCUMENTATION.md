# TODO APP

## Technical Details

* I prefer using MVVM architecture. Because it is simple to apply and pretty useful to separate ui logic and business logic, which makes readability easier.
* I prefer using Realm as local storage. 
* I didn't create a custom cell since it is said "Do not try to build a fancy UI" in technical requirements. So, I used default UITableViewCell.
* I used success and error handlers for realm operations. In error cases,  I presented alert to the user. In success cases, I made UI operations. It does not need to wrap UI operation with DispatchQueue.main.async, because it runs already in main thread.
* I created no data view which can be visible when there is no item in the list. 
* I create RealmManager singleton object to operate database operation. I sorted tasks by their last updated time.
* I used interface builder files to build UI. I embed the my list VC into an UINavigationController, and I assigned it as the root controller of the window in SceneDelegate.
* In detail screen, I used navigation bar buttons to operate save and delete functions. If the title and details are empty, I deleted the item from db. If the title and details are not updated, I didn’t make update operation. To see this logic you can examine checkAndUpdateItem function. Also, in detail screen, I added keyboard observers to observe show and hide notifications of the keyboard. Depend on them, I changed the textview’s bottom constraint to prevent that keyboard covers a part of textview. 
* In List VC, I refreshed the tableview in ViewWillAppear method. So after loading app and push-pop vc operations, list can be kept updated. 
* In List VC, I used leading and trailing swipe actions of the tableview. I used leading swipe action to make the task done or undone, trailing swipe action for deletion operation.

