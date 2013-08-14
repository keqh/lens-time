lens-time
=========

lens for Data.Time

Example
---------

```
$ ghci
> import Control.Lens
> import Data.Time
> import Data.Time.Lens
> t <- getCurrentTime
> t
2013-08-14 13:37:20.674759 UTC

> t ^. date
2013-08-14
> t ^. time
13:37:20.674759
> t ^. day
14

> day +~ 10 $ t
2013-08-24 13:37:20.674759 UTC
> day +~ 100 $ t
2013-11-22 13:37:20.674759 UTC
> day .~ 1 $ t
2013-08-01 13:37:20.674759 UTC
```

