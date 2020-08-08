#!/bin/bash

timestamp() {
  date +"%T"
}
emulator=$8

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
echo $base
mkdir -p $base
time_inicio="$(timestamp)"


for i in $(seq 1 $7);
do
  file=$base/out.$i.txt
 
  adb shell am instrument -w -r    -e class io.github.marktony.espresso.packages.AppNavigationTest#clickOnNavigationDrawerItem_ChangeTheme -e debug false io.github.marktony.espresso.test/android.support.test.runner.AndroidJUnitRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.BooksSortOrderTest#books_sortOrderAfterSettingsChange -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.CreatedAtPropertyTest#testCondition -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.CreatedAtPropertyTest#testNewNote -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.MiscTest#testScheduledWithRepeaterToDoneFromNoteFragment -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.MiscTest#testBookReparseOnStateConfigChange -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.NoteFragmentTest#testChangingStateSettingsFromNoteFragment -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.QueryFragmentTest#testInheritedTagsAfterMovingNote -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SettingsFragmentTest#testDefaultPriorityUpdateOnLowestPriorityChange -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SyncingTest#testAutoSyncIsTriggeredAfterCreatingNote -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SyncingTest#testBookParsingAfterKeywordsSettingChange -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SettingsChangeTest#testChangeDefaultPriorityAgendaResultsShouldBeReordered -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r  --no-window-animation  -e debug false -e class de.test.antennapod.playback.PlaybackTest#testReplayEpisodeContinuousPlaybackOff[builtin] de.test.antennapod/androidx.test.runner.AndroidJUnitRunner >> $file
  adb shell am instrument -w -r  --no-window-animation  -e debug false -e class de.test.antennapod.playback.PlaybackTest#testReplayEpisodeContinuousPlaybackOff[sonic] de.test.antennapod/androidx.test.runner.AndroidJUnitRunner >> $file
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.BookmarksTest#editBookmarkWithChangingContent_bookmarkIsUpdated -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.SearchFieldTest#typeTextInSearchFieldAndClear_textIsClearedAndBackToHome -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.BookmarksTest#editBookmarkWithVariousWords_bookmarkIsUpdated -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.ShareWithFriendTest#shareWithFriends -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  adb shell am instrument -w -r    -e class com.google.android.flexbox.test.FlexboxLayoutManagerTest#testChangeAttributesFromCode -e debug false com.google.android.flexbox.test/androidx.test.runner.AndroidJUnitRunner >> $file
  adb shell am instrument -w -r  --no-window-animation  -e debug false -e class de.test.antennapod.playback.PlaybackTest#testReplayEpisodeContinuousPlaybackOn[sonic] de.test.antennapod/androidx.test.runner.AndroidJUnitRunner >> $file
  adb shell am instrument -w -r    -e class org.catrobat.paintroid.test.espresso.tools.ShapeToolIntegrationTest#testRememberOutlineShapeAfterOrientationChange[Square] -e debug false org.catrobat.paintroid.test/android.support.test.runner.AndroidJUnitRunner >> $file
  adb shell am instrument -w -r    -e class org.catrobat.paintroid.test.espresso.LandscapeIntegrationTest#testFullscreenPortraitOrientationChangeWithShape -e debug false org.catrobat.paintroid.test/android.support.test.runner.AndroidJUnitRunner >> $file
  adb shell am instrument -w -r  --no-window-animation  -e debug false -e class de.test.antennapod.playback.PlaybackTest#testContinousPlaybackOffSingleEpisode[builtin] de.test.antennapod/androidx.test.runner.AndroidJUnitRunner >> $file
  adb shell am instrument -w -r  --no-window-animation  -e debug false -e class de.test.antennapod.playback.PlaybackTest#testStartLocal[sonic] de.test.antennapod/androidx.test.runner.AndroidJUnitRunner >> $file
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.NavigationTest#browsingWebsiteBackAndForward_backAndFrowardToWebsite -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  adb shell am instrument -w -r    -e class fr.neamar.kiss.androidTest.MainActivityTest#testSearchResultAppears -e debug false fr.neamar.kiss.debug.test/androidx.test.runner.AndroidJUnitRunner >> $file
  adb shell am instrument -w -r  --no-window-animation  -e debug false -e class de.test.antennapod.playback.PlaybackTest#testStartLocal[exoplayer] de.test.antennapod/androidx.test.runner.AndroidJUnitRunner >> $file
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.SearchSuggestionTest#clickSearchSuggestion_browseByDefaultSearchEngine -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  adb shell am instrument -w -r    -e class org.catrobat.paintroid.test.espresso.tools.ShapeToolIntegrationTest#testRememberOutlineShapeAfterOrientationChange[Heart] -e debug false org.catrobat.paintroid.test/android.support.test.runner.AndroidJUnitRunner >> $file
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.RemoveTopSitesTest#deleteTopSite_deleteSuccessfully -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.BookmarksTest#addBookmarkAndEdit_bookmarkIsUpdated -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.SettingsFragmentTest#testStateSummaryAfterNoStates -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.NoteFragmentTest#testMetadataShowSelectedOnNoteLoad -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r    -e class com.orgzly.android.espresso.CreatedAtPropertyTest#testChangeCreatedAtPropertyResultsShouldBeReordered -e debug false com.orgzly.test/com.orgzly.android.OrgzlyTestRunner >> $file
  adb shell am instrument -w -r -e disableAnalytics true -e clearPackageData true --no-window-animation  -e class org.mozilla.focus.activity.BookmarksTest#editBookmarkWithClearingLocationContent_saveButtonIsDisabled -e debug false org.mozilla.rocket.debug.denini.test/org.mozilla.focus.test.runner.CustomTestRunner >> $file

done

if [ $PID ]
then
  echo "kill stress"
  kill -9  $PID
fi


echo incio $time_inicio >> $base/time.txt
echo "fim $(timestamp)" >> $base/time.txt
echo "stress [$2, $3, $4, $5, $6]" > $base/stress.txt
sleep 7
