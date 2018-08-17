# WeChatDemo
WeChat 逆向Demo
WeChat 逆向Demo，设置页面 UI 展示，其中 TargetApp 文件夹应该拖入 WeChat 的 IPA ，但是 GitHub 上传默认有限制。

上传项目到GitHub上，当某个文件大小超过100M时，就会上传失败，因为默认的限制了上传文件大小不能超过100M。如果需要上传超过100M的文件，就需要我们自己去修改配置。

首先，打开终端，进入项目所在的文件夹；

输入命令：git config http.postBuffer 524288000

之前git中的配置是没有这一项的,执行完以上语句后输入

> git config -l

可以看到配置项的最下面多出了一行我们刚刚配置的内容. (52428000=500×1024×1024,即500M)GitHub上传文件不能超过100M

执行前：

CharlesdeMacBook-Air:WeChatDemo qichao$ git config -l
credential.helper=osxkeychain
filter.media.clean=git-media-clean %f
filter.media.smudge=git-media-smudge %f
user.name=Charles
user.email=qcsuperman168@sina.com
core.excludesfile=/Users/qichao/.gitignore_global
difftool.sourcetree.cmd=opendiff "$LOCAL" "$REMOTE"
difftool.sourcetree.path=
mergetool.sourcetree.cmd=/Applications/SourceTree.app/Contents/Resources/opendiff-w.sh "$LOCAL" "$REMOTE" -ancestor "$BASE" -merge "$MERGED"
mergetool.sourcetree.trustexitcode=true
filter.lfs.process=git-lfs filter-process
filter.lfs.required=true
filter.lfs.clean=git-lfs clean -- %f
filter.lfs.smudge=git-lfs smudge -- %f
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
core.ignorecase=true
core.precomposeunicode=true
submodule.active=.
remote.origin.url=https://github.com/IosSuperman/WeChatDemo.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
branch.master.remote=origin
branch.master.merge=refs/heads/master

执行后：

CharlesdeMacBook-Air:WeChatDemo qichao$ git config -l
credential.helper=osxkeychain
filter.media.clean=git-media-clean %f
filter.media.smudge=git-media-smudge %f
user.name=Charles
user.email=qcsuperman168@sina.com
core.excludesfile=/Users/qichao/.gitignore_global
difftool.sourcetree.cmd=opendiff "$LOCAL" "$REMOTE"
difftool.sourcetree.path=
mergetool.sourcetree.cmd=/Applications/SourceTree.app/Contents/Resources/opendiff-w.sh "$LOCAL" "$REMOTE" -ancestor "$BASE" -merge "$MERGED"
mergetool.sourcetree.trustexitcode=true
filter.lfs.process=git-lfs filter-process
filter.lfs.required=true
filter.lfs.clean=git-lfs clean -- %f
filter.lfs.smudge=git-lfs smudge -- %f
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
core.ignorecase=true
core.precomposeunicode=true
submodule.active=.
remote.origin.url=https://github.com/IosSuperman/WeChatDemo.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
branch.master.remote=origin
branch.master.merge=refs/heads/master
http.postbuffer=524288000
