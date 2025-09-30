The thing I really loved in Unity3D is the package manager.

Something I really disliked about it, though, is that instead of providing a server to the community—like **crate.io** in Rust or **NPM** in JavaScript—Unity created their own and then just gave us the tools to host packages ourselves.

But in Godot, we have something called the **Asset Library**, which is the equivalent:
[https://godotengine.org/asset-library/asset](https://godotengine.org/asset-library/asset)

So let’s explore what it is and what it allows us to do.

**Minimal Goal:** Make a Hello World package with just a print hello world in it.

____________


Documentation:   https://docs.godotengine.org/en/latest/community/asset_library/submitting_to_assetlib.html

Submit an asset:  
https://godotengine.org/asset-library/asset/submit  


> The Asset Library is different - all assets are distributed free of charge, and under a host of open source licenses (such as the MIT license, the GPL, and the Boost Software License).


- You can submit project and demo to the store but in a different section of Godot Library

-----------

Checklist:
- [ ] Respect the licence of the store MIT GPL ou Boost Software License
- [ ] Set as "Asset Library"

- [ ] Composition of your asset
  - [ ] Asset's thumbnail/icon.
  - [ ] Asset's name.
  - [ ] Current version number of the asset.
  - [ ] Asset's category, Godot version, and support status.
  - [ ] Asset's original author/submitter.
  - [ ] The license the asset is distributed under.
  - [ ] The date of the asset's latest edit/update.
  - [ ] A textual description of the asset.
  - [ ] Links related to the asset (download link, file list, issue tracker).
  - [ ] Images and videos showcasing the asset.
Requirements:
- [ ] The asset must work.
- [ ] The asset must have a proper .gitignore [Link](https://raw.githubusercontent.com/aaronfranke/gitignore/godot/Godot.gitignore)
- [x] No submodules
  - [ ] easy submodules are a pain in the ass
- [ ] The license needs to be correct.
    - [ ] LICENSE.md
      - [ ] license text itself
      - [ ]  a copyright statement that includes the year(s) and copyright holder.
      - [ ]  Use proper English for the name and description of your asset. This includes using correct capitalization,
- [ ]  The icon link must be a direct link.
  - [ ]  raw.githubusercontent.com
Recommendation
- [ ] "addons/asset_name/" folder
- [ ] Fix or suppress all script warnings
- [ ] Make your code conform to the official style guides
  - [ ] https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html#doc-gdscript-styleguide
- [ ] if you have screenshots in your repo, place them in their own subfolder and add an empty .gdignore file
- [ ] consider including example files in the asset.
- [ ] consider adding a .gitattributes file to your repo. 
- [ ] If you are submitting a plugin, add a copy of your license and readme to the plugin folder itself.
- [ ] consider hosting your asset's source code on GitHub.

Form to complete:
- [ ] Asset Name
- [ ] Category: addons
- [ ] Godot version
   - [ ] re-submit the asset multiple times
- [ ] Version: change every submit (Major.minor.path if possible)
  - [ ] https://semver.org/
- [ ] Repository host
- [ ] Repository URL:
- [ ] Download Commit:
- [ ] Icon URL: 128×128 PNG
  - [ ] https://raw.githubusercontent.com/<user>/<project>/<branch>/Icon.png
- [ ] License:
- [ ] Description:
- [ ] Type: of description
- [ ] Image/YouTube URL:
- [ ] Thumbnail URL:

Check state of the validation
- https://godotengine.org/asset-library/asset/edit?&asset=-1
