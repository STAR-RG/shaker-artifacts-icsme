#!/bin/bash

#emulator=4330

adb shell settings put global transition_animation_scale 0
adb shell settings put global window_animation_scale 0
adb shell settings put global animator_duration_scale 0


base=./outputs/normal
for i in $(seq $1);
do
  pat=$base/$i
  mkdir -p $pat
  echo $pat
  file=$pat/out.1.txt
  
  SECONDS=0
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.BookPrefaceTest#testPrefaceHiddenNotDisplayed -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.BookPrefaceTest#testPrefaceFullDisplayed -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.BookTest#testBackFromSettingsShouldReturnToPreviousFragment -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.BooksTest#testOpenSettings -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.CreatedAtPropertyTest#testSortOrder -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.MiscTest#testClearDatabaseWithFragmentsInBackStack -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.MiscTest#testBookTitleChangeOnPrefaceEdit -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.MiscTest#testScheduledWithRepeaterToDoneFromBook -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.NoteFragmentTest#testDeleteNote -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.QueryFragmentTest#testDeSelectRemovedNoteInSearch -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SavedSearchesFragmentTest#testExportSavedSearches -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SettingsChangeTest#testDisplayedContentInBook -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SettingsFragmentTest#testLowestPriorityUpdateOnDefaultPriorityChange -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SettingsFragmentTest#testAddingNewTodoKeywordInSettingsAndChangingStateToItForNewNote -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SettingsFragmentTest#testNewNoteDefaultStateIsSetInitially -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SettingsFragmentTest#testNewNoteDefaultStateIsInitiallyVisibleInSummary -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SettingsFragmentTest#testLowercaseStateConvertedToUppercase -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SettingsFragmentTest#testAddingNewTodoKeywordInSettingsNewNoteShouldHaveDefaultState -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SettingsFragmentTest#testStatesDuplicateDetectedIgnoringCase -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SyncingTest#testForceLoadingMultipleTimes -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SyncingTest#testPrefaceModificationMakesBookOutOfSync -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.QueryFragmentTest#testInheritedTagsAfterDemotingSubtree -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.MiscTest#testSelectingNoteThenOpeningAnotherBook -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class org.catrobat.paintroid.test.espresso.LandscapeIntegrationTest#testScrollToColorChooserOk -e debug false org.catrobat.paintroid.test/android.support.test.runner.AndroidJUnitRunner >> $file
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.BookmarksTest#removeBookmarkFromBookmarkList_bookmarkIsRemoved -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.BrowsingHistoryTest#browsingTwoWebSites_sitesAreDisplayedInOrderInHistoryPanel -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.SwitchSearchEngineTest#switchSearchEngine_searchViaSearchEngineAccordingly -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.SaveRestoreTabsTest#restoreEmptyTab_addNewTabThenRelaunch -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  adb shell am instrument -w -r    -e class org.catrobat.paintroid.test.espresso.LandscapeIntegrationTest#testColorPickerDialogSwitchTabsInLandscape -e debug false org.catrobat.paintroid.test/android.support.test.runner.AndroidJUnitRunner >> $file
  adb shell am instrument -w -r    -e class fr.neamar.kiss.androidTest.FavoritesTest#testExternalBarHiddenWhenViewingAllApps -e debug false fr.neamar.kiss.debug.test/androidx.test.runner.AndroidJUnitRunner >> $file
  adb shell am instrument -w -r  --no-window-animation  -e debug false -e class de.test.antennapod.playback.PlaybackTest#testReplayEpisodeContinuousPlaybackOn[exoplayer] de.test.antennapod/androidx.test.runner.AndroidJUnitRunner >> $file
  adb shell am instrument -w -r    -e class fr.neamar.kiss.androidTest.MainActivityTest#testKissBarEmptiesSearch -e debug false fr.neamar.kiss.debug.test/androidx.test.runner.AndroidJUnitRunner >> $file
  adb shell am instrument -w -r  --no-window-animation  -e debug false -e class de.test.antennapod.playback.PlaybackTest#testContinousPlaybackOffSingleEpisode[sonic] de.test.antennapod/androidx.test.runner.AndroidJUnitRunner >> $file
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.BrowsingIntentTest#appHasOneTabAndReceiveBrowsingIntent_tabIncreasedAndBrowse -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  adb shell am instrument -w -r  --no-window-animation  -e debug false -e class de.test.antennapod.playback.PlaybackTest#testStartLocal[builtin] de.test.antennapod/androidx.test.runner.AndroidJUnitRunner >> $file
  adb shell am instrument -w -r  --no-window-animation  -e debug false -e class de.test.antennapod.playback.PlaybackTest#testReplayEpisodeContinuousPlaybackOff[exoplayer] de.test.antennapod/androidx.test.runner.AndroidJUnitRunner >> $file
  adb shell am instrument -w -r  --no-window-animation  -e debug false -e class de.test.antennapod.playback.PlaybackTest#testReplayEpisodeContinuousPlaybackOn[builtin] de.test.antennapod/androidx.test.runner.AndroidJUnitRunner >> $file
  adb shell am instrument -w -r  --no-window-animation  -e debug false -e class de.test.antennapod.playback.PlaybackTest#testContinousPlaybackOffSingleEpisode[exoplayer] de.test.antennapod/androidx.test.runner.AndroidJUnitRunner >> $file
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.RateAppPromotionTest#showRateAppPromotionAndClickFeedback_openFeedbackUrl -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SettingsChangeTest#testChangeDefaultPrioritySearchResultsShouldBeReordered -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file

  echo $SECONDS >> $pat/time.txt
done

sleep 10
