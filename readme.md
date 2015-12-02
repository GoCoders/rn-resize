##rn-resize

###Install

`npm install rn-resize --save`

Drag `GCResize.xcodeproj` into your libraries folder and drag `GCResize.m` to `Compile Sources` under `Build Phases`. Follow the [React Native guide](https://facebook.github.io/react-native/docs/linking-libraries-ios.html) on linking libraries if you get stuck.

##Description

Resize images in React Native. Useful if you're using [react-native-camera](https://github.com/lwansbrough/react-native-camera) and want to upload files (using something like [react-native-file-transfer](https://github.com/kamilkp/react-native-file-transfer)) but you don't want the full, insanely huge resolution photos to be uploaded.

##Example

```js
import { GCResize } from 'NativeModules'

GCResize.path({
  image: this.props.image,
  width: 300,
  height: 500
}, resizedImage => this.setState({resizedImage}))
```

`options:`

The `image` key must be the full path to a photo on a device.

You can get the full path of the resized image by using `GCResize.path` (see example above) or the same syntax but call `GCResize.base64` to receive a base64 encoded string. Getting the full path is recommended.
