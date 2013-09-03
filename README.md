Dynamics-Play
=============

Exploring UIDymamics in iOS 7.

Project has a variety of tabbed views that demo some of the basics of UIKit's dynamics.


**Tab 1, Gravity**

View with a single button that has dynamic item behaviors and gravity. Tap the button to apply an instaneous force that propels the button upwards. Button will collide with the edges of the controller view (notice it goes under the tab bar).


**Tab 2, Angular**

View with a single button. Tapping the button will apply an angular velocity, spinning the view like a record or pinwheel. Notice that you can build up velocity with multiple taps and that the angularResistence property simulates a friction that eventually slows the spinning button. 


**Tab 3, Collisions**

View with many buttons that all collide with each other. Tapping a button implies an impulsive force. Note how despite that the buttons draw round, the collisions are all actually based on rectangles. 


**Tab 4, Attachment**

View with two buttons that attached with a spring-like attachment behavior. The button labeled '1' can be touched and dragged with the use of pan gesture recognizer. You can also 'fling' button 1. This view also adds a collision boundary at the tab bar so the buttons always stay above it.

### Notes

- There is a custom class, _LoggingDynamicItem_, that implements the DynamicItem protocol. It simply logs changse to the center and transform. You can use this to inspect what is happening with some behaviors.

- Each controller has it's own UIDynamicAnimator. It seems like these animators will continue to run even when you have switched to another tab and hidden the view the animator is associated with. It may be the case that using a single animator for all views is a better design. 


