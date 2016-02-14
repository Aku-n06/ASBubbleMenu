# ASBubbleMenu

Simple bubble menu animated :


![alt tag](https://github.com/scamps88/ASBubbleMenu/blob/master/README/animated.gif)


### installation :

- Just copy the ASMenuBubble folder to your project

### implementation :

- ti implement ASBubbleMenu just give him an array of UIimages and it will show them :

var bubbleMenu : ASMenuBubble!

bubbleMenu = ASMenuBubble(frame: CGRectZero)
bubbleMenu.showWithIcons(icons)


- the ASMenuBubbleDelegate protocol will return the index selected :

func ASMenuBubbleSelectedMenuItemAtIndex(index: NSInteger) {
}

- to close the menu just call this method :

bubbleMenu.closeAnimated()


