module Data.Time.Lens where

import Control.Lens
import qualified Data.Time as T
import Data.Fixed (Pico)

-- date
-- =============================================================================

-- type def
-- --------------------------------------------------------

class HasDate a where
    date :: Lens' a T.Day

instance HasDate T.UTCTime where
    date = lens T.utctDay setDate
      where
        setDate t newDate = t{ T.utctDay = newDate }

-- methods
-- --------------------------------------------------------

-- 型難しい……
dateLens selector adder = date `fmap` lens getter setter
  where
    getter t = T.toGregorian t ^. selector
    setter t new = adder (fromIntegral $ new - getter t) t

year :: HasDate a => Lens' a Integer
year = dateLens _1 T.addGregorianYearsRollOver

month :: HasDate a => Lens' a Int
month = dateLens _2 T.addGregorianMonthsRollOver

day :: HasDate a => Lens' a Int
day = dateLens _3 T.addDays

-- time
-- =============================================================================

-- type def
-- --------------------------------------------------------

class HasTime a where
    time :: Lens' a T.TimeOfDay

instance HasTime T.UTCTime where
    time = lens get set
      where
        get = T.timeToTimeOfDay . T.utctDayTime
        set t new = t{ T.utctDayTime = T.timeOfDayToTime new }

-- methods
-- --------------------------------------------------------

hour :: HasTime a => Lens' a Int
hour = time `fmap` lens T.todHour (\t new -> t{T.todHour = new})

minutes :: HasTime a => Lens' a Int
minutes = time `fmap` lens T.todMin (\t new -> t{T.todMin = new})

seconds :: HasTime a => Lens' a Pico
seconds = time `fmap` lens T.todSec (\t new -> t{T.todSec = new})
