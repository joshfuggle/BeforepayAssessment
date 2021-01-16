# BeforepayAssessment

## Screenshots

![Home 2](/Screenshots/home-2.png)
![Westpac Slide](/Screenshots/westpac.png)

![Home 1](/Screenshots/home-1.png)
![All Accounts Slide](/Screenshots/all-accounts.png)

## Discussion

### MVVM and Protocol-first Architecture

All major screens and some views define an abstract ViewModel protocol, which
clients will conform to.

Being a Protocol-based ViewModel design means that one screen can have very
different implementations of logic, making reusability easy.

For example, the `CarouselSlideViewController` has two concretions of its
view model `CarouselSlideViewModelProtocol`:

- `ClientCarouselSlideViewModel`: for representing all bank accounts held by
  an institution client (e.g. CBA)
- `InstitutionsSlideViewModel`: for representing a summary of all institutions.

### Injectability

In addition to MVVM, I placed emphasis on injectability. This is showcased in
the Theme concept, where a Theme object is carried between the various View
Controllers and Views.

This approach, in addition to being Protocol-based, meant that I could easily
style the carousel slides with minimal inlined code and have multiple Theme
implementations. For example, there is a StandardTheme object, and a BlueTheme
object for the Institution summary slide.

### Layout code

For the main layout technique, I chose **code layout constraints**. I chose
this technology for a few reasons:

- Storyboards suffers from a team perspective because it is quite difficult to
  resolve conflicts in Apple's XML format. In addition, it has poor readability
  and is not as good for dynamic UI's as code.
- SwiftUI addresses the Storyboard issues, however it is still immature
  and only supports iOS13+. Beforepay currently supports iOS12+.

### Unit Tests

This architecture is very supportive of unit tests. Added in a small number of
sample unit tests as a demonstration.

### Completeness

I made a few short-cuts in this assessment in the interest of time:

- I used the standard Apple UINavigationBar. This meant that the title is
  center aligned rather than left aligned.
- I used UIPageViewController to house the carousel. This meant that I couldn't
  partially reveal the subsequent slide, and that the page indicator lacks
  the nice animation in the mockup.
- **Didn't include the institution icons, as I couldn't find them in InVision**.
