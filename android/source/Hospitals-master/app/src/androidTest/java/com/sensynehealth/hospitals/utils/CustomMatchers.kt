package com.sensynehealth.hospitals.utils

import android.view.View
import androidx.recyclerview.widget.RecyclerView
import androidx.test.espresso.matcher.BoundedMatcher
import androidx.test.espresso.matcher.ViewMatchers.hasDescendant
import androidx.test.espresso.matcher.ViewMatchers.withId
import org.hamcrest.Description
import org.hamcrest.Matcher
import org.hamcrest.Matchers.allOf

class CustomMatchers {
    companion object {
        fun withItemCount(count: Int): Matcher<View> {
            return object : BoundedMatcher<View, RecyclerView>(RecyclerView::class.java) {
                override fun describeTo(description: Description?) {
                    description?.appendText("RecyclerView with item count: $count")
                }

                override fun matchesSafely(item: RecyclerView?): Boolean {
                    return item?.adapter?.itemCount == count
                }
            }
        }

        fun viewChildAtPosition(childId: Int, pos: Int, childMatcher: Matcher<View>): Matcher<View> {
            return object : BoundedMatcher<View, RecyclerView>(RecyclerView::class.java) {
                override fun describeTo(description: Description?) {
                    description?.appendText("Checks if the ${pos}th child of the view matches the desired condition.")
                }

                override fun matchesSafely(item: RecyclerView?): Boolean {
                    val viewHolder = item?.findViewHolderForAdapterPosition(pos)
                    val matcher = hasDescendant(allOf(withId(childId), childMatcher))
                    return viewHolder != null && matcher.matches(viewHolder.itemView)
                }
            }
        }
    }
}