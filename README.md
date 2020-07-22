# Mergeable

A framework for merging objects together.

## Features:

* Merge an object into an other.
> When you perform a merge operation it will return an object of the same type containing only the updated properties.
> In the example below the result object will not contain a value for firstName since it didn't change.
```swift
var user = User(firstName: "John",
                lastName: "Apple",
                postsCount: 24)

let updateUser = User(firstName: "John",
                        lastName: "Apple Seed")

let resultUser = user.merge(with: updateUser)

print(user)           // firstName: John, lastName: Apple, postsCount: 24
print(resultUser)      // lastName: Apple Seed
```

* Merge an object containing nested objects into an other.
> If objects contain **id** values you can optionally pass an **idKey** to `merge(with: )` function to spectify how to merge unique objects together.
> If an object contains an array of objects the **idKey** will be used.
> In the example below we are using **id** as the variable name for **ids** in our object.
> The merge function will update the **firstName** value of friend with **id: 1** and insert a second friend with **id: 2**.
> The result returned by this operation will also contain only fields that have changed after performing the merge operation.
```swift
var user = User(firstName: "Emma",
                friends: [User(id: "1", firstName: "Jo-hn")])

let updateUser = User(friends: [User(id: "1", firstName: "John"),
                                User(id: "2", firstName: "Apple")])

let resultUser = user.merge(with: updateUser, idKey: "id")

print(user)
// firstName: Emma,
// friends: [id: 1, firstName: John,
//           id: 2, firstName: Apple]

print(resultUser)
// friends: [firstName: John,
//           id: 2, firstName: Apple]
```

* Merge a Dictionary into an other Dictionary.
> Under the hood, this library converts Codable objects into dictionary objects using JSONEncoding, and convert them back to Codable objects using JSONDecoding once merge operations are applied.
> For this reason, this library also spports  merging a dictionary into an other dictionary in the same way.
