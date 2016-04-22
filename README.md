# ASBubbleMenu

Simple bubble menu animated :


![alt tag](https://github.com/scamps88/ASBubbleMenu/blob/master/README/animated.gif)


### installation :

- Just copy the ASMenuBubble folder to your project
- Or, if you are using CocoaPod, add the followind line to yur Podfile (adding the use_frameworks! flag at the end)

    pod 'ASBubbleMenu', :git => 'https://github.com/scamps88/ASBubbleMenu.git'

    use_frameworks!
    
### implementation :

- to implement ASBubbleMenu just give him an array of UIimages and it will show them :
    ```swift
    var bubbleMenu : ASMenuBubble!

    bubbleMenu = ASMenuBubble(frame: CGRectZero)
    bubbleMenu.showWithIcons(icons)
    ```

- the ASMenuBubbleDelegate protocol will return the index selected :
    ```swift
func ASMenuBubbleSelectedMenuItemAtIndex(index: NSInteger) {
}
    ```

- to close the menu just call this method :
    ```swift
    bubbleMenu.closeAnimated()
    ```




THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
