# maui-appcenter
This repo is a proof-of-concept of building .NET MAUI apps via AppCenter.
At this moment (March 2023) the AppCenter doesn't have an option to set up MAUI builds. But it's still possible to build MAUI apps.

The idea is that AppCenter have an option to set up 'post-clone' scripts and you can do virtually everything there.
So the trick is to do the following
- Build the app in 'post-clone' script
- Disable built-in AppCenter msbuild/nuget tasks

Building the app is easy, as it's just an one-line command thanks to 'dotnet publish'
Disabling the msbuild/nuget tasks is tricky, but can be done via following options:
1. override Mono's msbuild/nuget scripts
2. disable execution of AppCenter tasks

I've created the repo in my free time, just as an interesting experiment.
The pros of the approach:
- It works, you can continue using AppCenter with MAUI apps
- You fully control the build and can change anything according to your needs

The cons are:
- Tricky way of bypassing AppCenter tasks, you might have to adjust it every time once AppCenter build definitions are changed 