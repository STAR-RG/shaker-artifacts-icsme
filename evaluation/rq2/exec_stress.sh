#!/bin/bash

emulator=$7

##stress
if [ $6 == 1 ]
then
  echo '>1'
  taskset -c -pa 0 $emulator > trash.txt
fi
if [ $6 == 2 ]
then
  echo '>2'
  taskset -c -pa 0,1 $emulator > trash.txt
fi
if [ $6 == 3 ]
then
  echo '>3'
  taskset -c -pa 0,1,2 $emulator > trash.txt
fi
if [ $6 == 4 ]
then
  taskset -c -pa 0,1,2,3 $emulator > trash.txt
fi

if [ $2 ]
then
  stress-ng --cpu $2 --cpu-load $3% --vm $4 --vm-bytes $5% &
  PID=$!
fi


base=./outputs/$1
mkdir -p $base

  SECONDS=0
  file=$base/out.$7.txt
  echo $file


  adb shell settings put global transition_animation_scale 1
  adb shell settings put global window_animation_scale 1
  adb shell settings put global animator_duration_scale 1

  
  echo -n "Running tests now."
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.BookPrefaceTest#testPrefaceHiddenNotDisplayed -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.BookPrefaceTest#testPrefaceFullDisplayed -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.BookTest#testBackFromSettingsShouldReturnToPreviousFragment -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.BooksTest#testOpenSettings -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.CreatedAtPropertyTest#testSortOrder -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell settings put global transition_animation_scale 1
  adb shell settings put global window_animation_scale 1
  adb shell settings put global animator_duration_scale 1

  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.MiscTest#testClearDatabaseWithFragmentsInBackStack -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.MiscTest#testBookTitleChangeOnPrefaceEdit -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.MiscTest#testScheduledWithRepeaterToDoneFromBook -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.NoteFragmentTest#testDeleteNote -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.QueryFragmentTest#testDeSelectRemovedNoteInSearch -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SavedSearchesFragmentTest#testExportSavedSearches -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  
  # adb shell settings put global transition_animation_scale 1
  # adb shell settings put global window_animation_scale 1
  # adb shell settings put global animator_duration_scale 1
  
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SettingsChangeTest#testDisplayedContentInBook -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SettingsFragmentTest#testLowestPriorityUpdateOnDefaultPriorityChange -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SettingsFragmentTest#testAddingNewTodoKeywordInSettingsAndChangingStateToItForNewNote -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SettingsFragmentTest#testNewNoteDefaultStateIsSetInitially -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SettingsFragmentTest#testNewNoteDefaultStateIsInitiallyVisibleInSummary -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  
  # adb shell settings put global transition_animation_scale 1
  # adb shell settings put global window_animation_scale 1
  # adb shell settings put global animator_duration_scale 1

  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SettingsFragmentTest#testLowercaseStateConvertedToUppercase -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SettingsFragmentTest#testAddingNewTodoKeywordInSettingsNewNoteShouldHaveDefaultState -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SettingsFragmentTest#testStatesDuplicateDetectedIgnoringCase -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SyncingTest#testForceLoadingMultipleTimes -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SyncingTest#testPrefaceModificationMakesBookOutOfSync -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.QueryFragmentTest#testInheritedTagsAfterDemotingSubtree -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # adb shell settings put global transition_animation_scale 1
  # adb shell settings put global window_animation_scale 1
  # adb shell settings put global animator_duration_scale 1

  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.MiscTest#testSelectingNoteThenOpeningAnotherBook -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  echo -n "."
  adb shell am instrument -w -r    -e class org.catrobat.paintroid.test.espresso.LandscapeIntegrationTest#testScrollToColorChooserOk -e debug false org.catrobat.paintroid.test/android.support.test.runner.AndroidJUnitRunner >> $file
  echo -n "."
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.BookmarksTest#removeBookmarkFromBookmarkList_bookmarkIsRemoved -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.BrowsingHistoryTest#browsingTwoWebSites_sitesAreDisplayedInOrderInHistoryPanel -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.SwitchSearchEngineTest#switchSearchEngine_searchViaSearchEngineAccordingly -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.SaveRestoreTabsTest#restoreEmptyTab_addNewTabThenRelaunch -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  adb shell settings put global transition_animation_scale 1
  adb shell settings put global window_animation_scale 1
  adb shell settings put global animator_duration_scale 1

  # echo -n "."
  # adb shell am instrument -w -r    -e class org.catrobat.paintroid.test.espresso.LandscapeIntegrationTest#testColorPickerDialogSwitchTabsInLandscape -e debug false org.catrobat.paintroid.test/android.support.test.runner.AndroidJUnitRunner >> $file
  echo -n "."
  adb shell am instrument -w -r    -e class fr.neamar.kiss.androidTest.FavoritesTest#testExternalBarHiddenWhenViewingAllApps -e debug false fr.neamar.kiss.debug.test/androidx.test.runner.AndroidJUnitRunner >> $file
  echo -n "."
  adb shell am instrument -w -r  --no-window-animation  -e debug false -e class de.test.antennapod.playback.PlaybackTest#testReplayEpisodeContinuousPlaybackOn[exoplayer] de.test.antennapod/androidx.test.runner.AndroidJUnitRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class fr.neamar.kiss.androidTest.MainActivityTest#testKissBarEmptiesSearch -e debug false fr.neamar.kiss.debug.test/androidx.test.runner.AndroidJUnitRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r  --no-window-animation  -e debug false -e class de.test.antennapod.playback.PlaybackTest#testContinousPlaybackOffSingleEpisode[sonic] de.test.antennapod/androidx.test.runner.AndroidJUnitRunner >> $file
  adb shell settings put global transition_animation_scale 1
  adb shell settings put global window_animation_scale 1
  adb shell settings put global animator_duration_scale 1
  
  # echo -n "."
  # adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.BrowsingIntentTest#appHasOneTabAndReceiveBrowsingIntent_tabIncreasedAndBrowse -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r  --no-window-animation  -e debug false -e class de.test.antennapod.playback.PlaybackTest#testStartLocal[builtin] de.test.antennapod/androidx.test.runner.AndroidJUnitRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r  --no-window-animation  -e debug false -e class de.test.antennapod.playback.PlaybackTest#testReplayEpisodeContinuousPlaybackOff[exoplayer] de.test.antennapod/androidx.test.runner.AndroidJUnitRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r  --no-window-animation  -e debug false -e class de.test.antennapod.playback.PlaybackTest#testReplayEpisodeContinuousPlaybackOn[builtin] de.test.antennapod/androidx.test.runner.AndroidJUnitRunner >> $file
  
  # adb shell settings put global transition_animation_scale 1
  # adb shell settings put global window_animation_scale 1
  # adb shell settings put global animator_duration_scale 1

  # echo -n "."
  # adb shell am instrument -w -r  --no-window-animation  -e debug false -e class de.test.antennapod.playback.PlaybackTest#testContinousPlaybackOffSingleEpisode[exoplayer] de.test.antennapod/androidx.test.runner.AndroidJUnitRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.RateAppPromotionTest#showRateAppPromotionAndClickFeedback_openFeedbackUrl -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SettingsChangeTest#testChangeDefaultPrioritySearchResultsShouldBeReordered -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file


  echo -n "."
  adb shell am instrument -w -r    -e class io.github.marktony.espresso.packages.AppNavigationTest#clickOnNavigationDrawerItem_ChangeTheme -e debug false io.github.marktony.espresso.test/android.support.test.runner.AndroidJUnitRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.BooksSortOrderTest#books_sortOrderAfterSettingsChange -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.CreatedAtPropertyTest#testCondition -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  
  adb shell settings put global transition_animation_scale 1
  adb shell settings put global window_animation_scale 1
  adb shell settings put global animator_duration_scale 1

  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.CreatedAtPropertyTest#testNewNote -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.MiscTest#testScheduledWithRepeaterToDoneFromNoteFragment -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.MiscTest#testBookReparseOnStateConfigChange -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.NoteFragmentTest#testChangingStateSettingsFromNoteFragment -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.QueryFragmentTest#testInheritedTagsAfterMovingNote -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SettingsFragmentTest#testDefaultPriorityUpdateOnLowestPriorityChange -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SyncingTest#testAutoSyncIsTriggeredAfterCreatingNote -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  
  # adb shell settings put global transition_animation_scale 1
  # adb shell settings put global window_animation_scale 1
  # adb shell settings put global animator_duration_scale 1

  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SyncingTest#testBookParsingAfterKeywordsSettingChange -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SettingsChangeTest#testChangeDefaultPriorityAgendaResultsShouldBeReordered -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r  --no-window-animation  -e debug false -e class de.test.antennapod.playback.PlaybackTest#testReplayEpisodeContinuousPlaybackOff[builtin] de.test.antennapod/androidx.test.runner.AndroidJUnitRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r  --no-window-animation  -e debug false -e class de.test.antennapod.playback.PlaybackTest#testReplayEpisodeContinuousPlaybackOff[sonic] de.test.antennapod/androidx.test.runner.AndroidJUnitRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.BookmarksTest#editBookmarkWithChangingContent_bookmarkIsUpdated -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.SearchFieldTest#typeTextInSearchFieldAndClear_textIsClearedAndBackToHome -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  
  # adb shell settings put global transition_animation_scale 1
  # adb shell settings put global window_animation_scale 1
  # adb shell settings put global animator_duration_scale 1

  # echo -n "."
  # adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.BookmarksTest#editBookmarkWithVariousWords_bookmarkIsUpdated -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.ShareWithFriendTest#shareWithFriends -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  echo -n "."
  adb shell am instrument -w -r    -e class com.google.android.flexbox.test.FlexboxLayoutManagerTest#testChangeAttributesFromCode -e debug false com.google.android.flexbox.test/androidx.test.runner.AndroidJUnitRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r  --no-window-animation  -e debug false -e class de.test.antennapod.playback.PlaybackTest#testReplayEpisodeContinuousPlaybackOn[sonic] de.test.antennapod/androidx.test.runner.AndroidJUnitRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class org.catrobat.paintroid.test.espresso.tools.ShapeToolIntegrationTest#testRememberOutlineShapeAfterOrientationChange[Square] -e debug false org.catrobat.paintroid.test/android.support.test.runner.AndroidJUnitRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class org.catrobat.paintroid.test.espresso.LandscapeIntegrationTest#testFullscreenPortraitOrientationChangeWithShape -e debug false org.catrobat.paintroid.test/android.support.test.runner.AndroidJUnitRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r  --no-window-animation  -e debug false -e class de.test.antennapod.playback.PlaybackTest#testContinousPlaybackOffSingleEpisode[builtin] de.test.antennapod/androidx.test.runner.AndroidJUnitRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r  --no-window-animation  -e debug false -e class de.test.antennapod.playback.PlaybackTest#testStartLocal[sonic] de.test.antennapod/androidx.test.runner.AndroidJUnitRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.NavigationTest#browsingWebsiteBackAndForward_backAndFrowardToWebsite -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  
  adb shell settings put global transition_animation_scale 1
  adb shell settings put global window_animation_scale 1
  adb shell settings put global animator_duration_scale 1

  # echo -n "."
  # adb shell am instrument -w -r    -e class fr.neamar.kiss.androidTest.MainActivityTest#testSearchResultAppears -e debug false fr.neamar.kiss.debug.test/androidx.test.runner.AndroidJUnitRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r  --no-window-animation  -e debug false -e class de.test.antennapod.playback.PlaybackTest#testStartLocal[exoplayer] de.test.antennapod/androidx.test.runner.AndroidJUnitRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.SearchSuggestionTest#clickSearchSuggestion_browseByDefaultSearchEngine -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class org.catrobat.paintroid.test.espresso.tools.ShapeToolIntegrationTest#testRememberOutlineShapeAfterOrientationChange[Heart] -e debug false org.catrobat.paintroid.test/android.support.test.runner.AndroidJUnitRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.RemoveTopSitesTest#deleteTopSite_deleteSuccessfully -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.BookmarksTest#addBookmarkAndEdit_bookmarkIsUpdated -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  
  # adb shell settings put global transition_animation_scale 1
  # adb shell settings put global window_animation_scale 1
  # adb shell settings put global animator_duration_scale 1
  
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SettingsFragmentTest#testStateSummaryAfterNoStates -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.NoteFragmentTest#testMetadataShowSelectedOnNoteLoad -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r    -e class com.orgzly.android.espresso.CreatedAtPropertyTest#testChangeCreatedAtPropertyResultsShouldBeReordered -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  # echo -n "."
  # adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.BookmarksTest#editBookmarkWithClearingLocationContent_saveButtonIsDisabled -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file

  echo "."
  echo "Finished."
  echo $SECONDS >> $base/time.txt

if [ $PID ]
then
  echo "matou stress"
  kill -9  $PID
fi


