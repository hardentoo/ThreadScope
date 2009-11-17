-------------------------------------------------------------------------------
-- This module implements the drawing of bookmarks in the Cario timeline
-- canvas. It obtains the list of bookmarks from the list view of bookmarks
-- and then renders the bookmarks in view.
-------------------------------------------------------------------------------

module Timeline.RenderBookmarks (renderBookmarks)
where

import Timeline.WithViewScale

import Graphics.UI.Gtk
import Graphics.Rendering.Cairo
import State
import CairoDrawing
import ViewerColours

import GHC.RTS.Events hiding (Event)

-------------------------------------------------------------------------------

renderBookmarks :: ViewerState -> ViewParameters -> Render () 
renderBookmarks state@ViewerState{..} params@ViewParameters{..} 
  = withViewScale params $ do
         -- Get the list of bookmarks
         bookmarkList <- liftIO $ listStoreToList bookmarkStore
         -- Render the bookmarks
         -- First set the line width to one pixel and set the line colour
         (onePixel, _) <- deviceToUserDistance 1 0
         setLineWidth onePixel 
         setSourceRGBAhex bookmarkColour 1.0
         mapM_ (drawBookmark height) bookmarkList
         return ()

-------------------------------------------------------------------------------

drawBookmark :: Int -> Timestamp -> Render ()
drawBookmark height bookmarkTime 
  = draw_line (bookmarkTime, 0) (bookmarkTime, height)

-------------------------------------------------------------------------------
