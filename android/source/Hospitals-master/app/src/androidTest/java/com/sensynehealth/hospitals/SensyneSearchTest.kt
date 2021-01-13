package com.sensynehealth.hospitals

import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.Espresso.pressBack
import androidx.test.espresso.action.ViewActions.click
import androidx.test.espresso.action.ViewActions.typeText
import androidx.test.espresso.assertion.ViewAssertions.matches
import androidx.test.espresso.contrib.RecyclerViewActions
import androidx.test.espresso.matcher.ViewMatchers.*
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import androidx.test.rule.ActivityTestRule
import androidx.test.uiautomator.By
import androidx.test.uiautomator.UiDevice
import androidx.test.uiautomator.Until
import com.sensynehealth.hospitals.ui.list.HospitalAdapter
import com.sensynehealth.hospitals.utils.CustomActions.Companion.onChildAtPosition
import com.sensynehealth.hospitals.utils.CustomMatchers.Companion.viewChildAtPosition
import com.sensynehealth.hospitals.utils.CustomMatchers.Companion.withItemCount
import com.sensynehealth.hospitals.utils.TestData
import org.hamcrest.Matchers.allOf
import org.hamcrest.Matchers.not
import org.junit.After
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class SensyneSearchTest {

    private lateinit var device: UiDevice

    @get:Rule
    val activityRule = ActivityTestRule(MainActivity::class.java, false, false)

    @Before
    fun setUp() {
        // On more complex tests you might need to access the context, in this case this one example
        // of how you could get it
        // val context = InstrumentationRegistry.getInstrumentation().targetContext.applicationContext

        device = UiDevice.getInstance(InstrumentationRegistry.getInstrumentation())

        activityRule.launchActivity(null)
    }

    @After
    fun tearDown() {
        activityRule.finishActivity()
    }

    @Test
    fun `Main screen check UI elements`() {
        onView(withId(TestData.MAIN_SCREEN_SEARCH_BUTTON)).check(matches(isDisplayed()))

        Thread.sleep(TestData.DEFAULT_TIMEOUT/2)

        onView(withId(R.id.list)).check(matches(
            viewChildAtPosition(
                TestData.MAIN_SCREEN_HOSPITAL_NAME,
                TestData.DEFAULT_CELL_POS_TO_CHECK,
                isDisplayed())
        ))
        onView(withId(R.id.list)).check(matches(
            viewChildAtPosition(
                TestData.MAIN_SCREEN_HOSPITAL_NAME,
                TestData.DEFAULT_CELL_POS_TO_CHECK,
                withText(TestData.FIRST_HOSPITAL_NAME_NO_SEARCH))
        ))
        onView(withId(R.id.list)).check(matches(
            viewChildAtPosition(
                TestData.MAIN_SCREEN_HOSPITAL_TYPE,
                TestData.DEFAULT_CELL_POS_TO_CHECK,
                isDisplayed())
        ))
        onView(withId(R.id.list)).check(matches(
            viewChildAtPosition(
                TestData.MAIN_SCREEN_HOSPITAL_TYPE,
                TestData.DEFAULT_CELL_POS_TO_CHECK,
                withText(TestData.FIRST_HOSPITAL_TYPE_NO_SEARCH))
        ))
    }

    @Test
    fun `Test search by organisation first name`() {
//        ActivityScenario.launch(MainActivity::class.java)

        onView(withId(TestData.MAIN_SCREEN_SEARCH_BUTTON)).check(matches(isDisplayed()))
        onView(withId(TestData.MAIN_SCREEN_SEARCH_BUTTON)).perform(click())

        onView(withId(TestData.MAIN_SCREEN_SEARCH_TEXT)).check(matches(isDisplayed()))
        onView(withId(TestData.MAIN_SCREEN_SEARCH_TEXT)).perform(typeText(TestData.DEFAULT_SEARCH_STRING))

        onView(withId(TestData.MAIN_SCREEN_LIST)).check(matches(withItemCount(TestData.DEFAULT_SEARCH_COUNT)))
    }

    @Test
    fun `Test can display the last element`() {
        onView(withId(TestData.MAIN_SCREEN_SEARCH_BUTTON)).check(matches(isDisplayed()))
        onView(withId(TestData.MAIN_SCREEN_SEARCH_BUTTON)).perform(click())

        onView(withId(TestData.MAIN_SCREEN_SEARCH_TEXT)).check(matches(isDisplayed()))
        onView(withId(TestData.MAIN_SCREEN_SEARCH_TEXT)).perform(typeText(TestData.DEFAULT_SEARCH_STRING))

        onView(withId(TestData.MAIN_SCREEN_LIST)).perform(RecyclerViewActions.
            scrollToPosition<HospitalAdapter.HospitalHolder>(TestData.DEFAULT_SEARCH_COUNT - 1))

        onView(withId(R.id.list)).check(matches(
            viewChildAtPosition(
                TestData.MAIN_SCREEN_HOSPITAL_NAME,
                TestData.DEFAULT_SEARCH_COUNT - 1,
                isCompletelyDisplayed())
        ))
    }

    @Test
    fun `Test can retain search result after opening a new view and go back`() {
        onView(withId(TestData.MAIN_SCREEN_SEARCH_BUTTON)).check(matches(isDisplayed()))
        onView(withId(TestData.MAIN_SCREEN_SEARCH_BUTTON)).perform(click())

        onView(withId(TestData.MAIN_SCREEN_SEARCH_TEXT)).check(matches(isDisplayed()))
        onView(withId(TestData.MAIN_SCREEN_SEARCH_TEXT)).perform(typeText(TestData.DEFAULT_SEARCH_STRING))

        onView(withId(TestData.MAIN_SCREEN_LIST)).check(matches(
            viewChildAtPosition(
                TestData.MAIN_SCREEN_HOSPITAL_NAME,
                TestData.DEFAULT_CELL_POS_TO_CHECK,
                withText(TestData.FIRST_HOSPITAL_NAME_FROM_SEARCH))
        ))
        onView(withId(R.id.list)).perform(onChildAtPosition(click(), TestData.DEFAULT_CELL_POS_TO_CHECK, null))

        pressBack()

        onView(withId(R.id.list)).check(matches(
            viewChildAtPosition(
                TestData.MAIN_SCREEN_HOSPITAL_NAME,
                TestData.DEFAULT_CELL_POS_TO_CHECK,
                withText(TestData.FIRST_HOSPITAL_NAME_FROM_SEARCH))
        ))
    }

    @Test
    fun `Test closing search when clicking close button`() {
        onView(withId(TestData.MAIN_SCREEN_SEARCH_BUTTON)).check(matches(isDisplayed()))
        onView(withId(TestData.MAIN_SCREEN_SEARCH_BUTTON)).perform(click())

        onView(withId(TestData.MAIN_SCREEN_SEARCH_TEXT)).check(matches(isDisplayed()))
        onView(withId(TestData.MAIN_SCREEN_SEARCH_TEXT)).perform(typeText(TestData.DEFAULT_SEARCH_STRING))
        onView(withId(TestData.MAIN_SCREEN_SEARCH_TEXT)).check(matches(allOf(isFocused(), withText(TestData.DEFAULT_SEARCH_STRING))))
        onView(withId(TestData.MAIN_SCREEN_SEARCH_CLOSE_BUTTON)).perform(click())
        onView(withId(TestData.MAIN_SCREEN_SEARCH_TEXT)).check(
            matches(allOf(
                isNotFocused(),
                not(withText(TestData.DEFAULT_SEARCH_STRING)),
                not(isDisplayed()))
            )
        )
    }

    @Test
    fun `Test results changes as user types`() {
        onView(withId(TestData.MAIN_SCREEN_SEARCH_BUTTON)).check(matches(isDisplayed()))
        onView(withId(TestData.MAIN_SCREEN_SEARCH_BUTTON)).perform(click())

        onView(withId(TestData.MAIN_SCREEN_SEARCH_TEXT)).check(matches(isDisplayed()))
        onView(withId(TestData.MAIN_SCREEN_SEARCH_TEXT)).perform(typeText(TestData.DEFAULT_SEARCH_STRING.subSequence(0, 1).toString()))

        onView(withId(R.id.list)).check(matches(
            viewChildAtPosition(
                TestData.MAIN_SCREEN_HOSPITAL_NAME,
                TestData.DEFAULT_CELL_POS_TO_CHECK,
                withText(TestData.FIRST_HOSPITAL_NAME_SEARCH_B))
        ))

        onView(withId(TestData.MAIN_SCREEN_SEARCH_TEXT)).perform(typeText(TestData.DEFAULT_SEARCH_STRING.subSequence(1, 2).toString()))

        onView(withId(R.id.list)).check(matches(
            viewChildAtPosition(
                TestData.MAIN_SCREEN_HOSPITAL_NAME,
                TestData.DEFAULT_CELL_POS_TO_CHECK,
                withText(TestData.FIRST_HOSPITAL_NAME_FROM_SEARCH))
        ))
    }

    @Test
    fun `Test lower case and uppercase returns the same results`() {
        onView(withId(TestData.MAIN_SCREEN_SEARCH_BUTTON)).check(matches(isDisplayed()))
        onView(withId(TestData.MAIN_SCREEN_SEARCH_BUTTON)).perform(click())

        onView(withId(TestData.MAIN_SCREEN_SEARCH_TEXT)).check(matches(isDisplayed()))
        onView(withId(TestData.MAIN_SCREEN_SEARCH_TEXT)).perform(typeText(TestData.DEFAULT_SEARCH_STRING))

        onView(withId(TestData.MAIN_SCREEN_LIST)).check(matches(
            viewChildAtPosition(
                TestData.MAIN_SCREEN_HOSPITAL_NAME,
                TestData.DEFAULT_CELL_POS_TO_CHECK,
                withText(TestData.FIRST_HOSPITAL_NAME_FROM_SEARCH))
        ))

        onView(withId(TestData.MAIN_SCREEN_SEARCH_CLOSE_BUTTON)).perform(click())

        onView(withId(TestData.MAIN_SCREEN_SEARCH_BUTTON)).check(matches(isDisplayed()))
        onView(withId(TestData.MAIN_SCREEN_SEARCH_BUTTON)).perform(click())

        onView(withId(TestData.MAIN_SCREEN_SEARCH_TEXT)).check(matches(isDisplayed()))
        onView(withId(TestData.MAIN_SCREEN_SEARCH_TEXT)).perform(typeText(TestData.DEFAULT_SEARCH_STRING.toLowerCase()))

        onView(withId(R.id.list)).check(matches(
            viewChildAtPosition(
                TestData.MAIN_SCREEN_HOSPITAL_NAME,
                TestData.DEFAULT_CELL_POS_TO_CHECK,
                withText(TestData.FIRST_HOSPITAL_NAME_FROM_SEARCH))
        ))
    }

    @Test
    fun `Detail screen check UI elements`() {
        onView(withId(TestData.MAIN_SCREEN_SEARCH_BUTTON)).check(matches(isDisplayed()))
        onView(withId(TestData.MAIN_SCREEN_SEARCH_BUTTON)).perform(click())

        onView(withId(TestData.MAIN_SCREEN_SEARCH_TEXT)).check(matches(isDisplayed()))
        onView(withId(TestData.MAIN_SCREEN_SEARCH_TEXT)).perform(typeText(TestData.DEFAULT_SEARCH_STRING))

        onView(withId(TestData.MAIN_SCREEN_LIST)).perform(onChildAtPosition(click(), TestData.DEFAULT_CELL_POS_TO_CHECK, null))

        onView(withId(TestData.DETAIL_SCREEN_HOSPITAL_NAME)).check(matches(isDisplayed()))
        onView(withId(TestData.DETAIL_SCREEN_HOSPITAL_NAME)).check(matches(withText("Name: ${TestData.FIRST_HOSPITAL_NAME_FROM_SEARCH}")))

        onView(withId(TestData.DETAIL_SCREEN_HOSPITAL_SUBTYPE)).check(matches(isDisplayed()))
        onView(withId(TestData.DETAIL_SCREEN_HOSPITAL_SUBTYPE)).check(matches(withText("Subtype: ${TestData.FIRST_HOSPITAL_SUBTYPE_FROM_SEARCH}")))

        onView(withId(TestData.DETAIL_SCREEN_HOSPITAL_SECTOR)).check(matches(isDisplayed()))
        onView(withId(TestData.DETAIL_SCREEN_HOSPITAL_SECTOR)).check(matches(withText("Sector: ${TestData.FIRST_HOSPITAL_SECTOR_FROM_SEARCH}")))

        onView(withId(TestData.DETAIL_SCREEN_ADDRESS_LABEL)).check(matches(isDisplayed()))
        onView(withId(TestData.DETAIL_SCREEN_ADDRESS_LABEL)).check(matches(withText("Address:")))

        onView(withId(TestData.DETAIL_SCREEN_HOSPITAL_ADDRESS1)).check(matches(isDisplayed()))
        onView(withId(TestData.DETAIL_SCREEN_HOSPITAL_ADDRESS1)).check(matches(withText(TestData.FIRST_HOSPITAL_ADDRESS1_FROM_SEARCH)))

        onView(withId(TestData.DETAIL_SCREEN_HOSPITAL_ADDRESS2)).check(matches(isDisplayed()))
        onView(withId(TestData.DETAIL_SCREEN_HOSPITAL_ADDRESS2)).check(matches(withText(TestData.FIRST_HOSPITAL_ADDRESS2_FROM_SEARCH)))

        onView(withId(TestData.DETAIL_SCREEN_HOSPITAL_ADDRESS4)).check(matches(isDisplayed()))
        onView(withId(TestData.DETAIL_SCREEN_HOSPITAL_ADDRESS4)).check(matches(withText(TestData.FIRST_HOSPITAL_ADDRESS4_FROM_SEARCH)))

        onView(withId(TestData.DETAIL_SCREEN_HOSPITAL_WEBSITE)).check(matches(isDisplayed()))
        onView(withId(TestData.DETAIL_SCREEN_HOSPITAL_WEBSITE)).check(matches(withText("Website: ${TestData.FIRST_HOSPITAL_WEBSITE_FROM_SEARCH}")))

        onView(withId(TestData.DETAIL_SCREEN_HOSPITAL_PHONE)).check(matches(isDisplayed()))
        onView(withId(TestData.DETAIL_SCREEN_HOSPITAL_PHONE)).check(matches(withText("Phone: ${TestData.FIRST_HOSPITAL_PHONE_FROM_SEARCH}")))
    }

    @Test
    fun `Test open the organisation website`() {
        onView(withId(TestData.MAIN_SCREEN_SEARCH_BUTTON)).check(matches(isDisplayed()))
        onView(withId(TestData.MAIN_SCREEN_SEARCH_BUTTON)).perform(click())

        onView(withId(TestData.MAIN_SCREEN_SEARCH_TEXT)).check(matches(isDisplayed()))
        onView(withId(TestData.MAIN_SCREEN_SEARCH_TEXT)).perform(typeText(TestData.DEFAULT_SEARCH_STRING))

        onView(withId(TestData.MAIN_SCREEN_LIST)).perform(onChildAtPosition(click(), TestData.DEFAULT_CELL_POS_TO_CHECK, null))

        onView(withId(TestData.DETAIL_SCREEN_HOSPITAL_WEBSITE)).check(matches(isDisplayed()))
        onView(withId(TestData.DETAIL_SCREEN_HOSPITAL_WEBSITE)).perform(click())

        device.wait(Until.hasObject(By.pkg("com.android.chrome").depth(0)), TestData.DEFAULT_TIMEOUT)
        device.pressBack()
    }

    @Test
    fun `Test call the organisation number`() {
        onView(withId(TestData.MAIN_SCREEN_SEARCH_BUTTON)).check(matches(isDisplayed()))
        onView(withId(TestData.MAIN_SCREEN_SEARCH_BUTTON)).perform(click())

        onView(withId(TestData.MAIN_SCREEN_SEARCH_TEXT)).check(matches(isDisplayed()))
        onView(withId(TestData.MAIN_SCREEN_SEARCH_TEXT)).perform(typeText(TestData.DEFAULT_SEARCH_STRING))

        onView(withId(TestData.MAIN_SCREEN_LIST)).perform(onChildAtPosition(click(), TestData.DEFAULT_CELL_POS_TO_CHECK, null))

        onView(withId(TestData.DETAIL_SCREEN_HOSPITAL_PHONE)).check(matches(isDisplayed()))
        onView(withId(TestData.DETAIL_SCREEN_HOSPITAL_PHONE)).perform(click())

        device.wait(Until.hasObject(By.pkg("com.android.phone").depth(0)), TestData.DEFAULT_TIMEOUT)
        device.pressBack()
    }
}