package com.sensynehealth.hospitals.utils

import android.view.View
import androidx.recyclerview.widget.RecyclerView
import androidx.test.espresso.PerformException
import androidx.test.espresso.UiController
import androidx.test.espresso.ViewAction
import androidx.test.espresso.matcher.ViewMatchers.*
import androidx.test.espresso.util.HumanReadables
import androidx.test.espresso.util.TreeIterables
import org.hamcrest.Matcher
import org.hamcrest.Matchers.allOf
import java.util.concurrent.TimeoutException

class CustomActions {
    companion object {
        fun onChildAtPosition(action: ViewAction, pos: Int, childId: Int?): ViewAction {
            return object :  ViewAction {
                override fun getDescription(): String {
                    return "Perform action on the ${pos}th child of the view"
                }

                override fun getConstraints(): Matcher<View> {
                    return allOf(isDisplayed(), isAssignableFrom(View::class.java))
                }

                override fun perform(uiController: UiController?, view: View?) {
                    view?.let { v ->
                        if (v is RecyclerView) {
                            action.perform(uiController, v.findViewHolderForAdapterPosition(pos)!!.itemView)
                        } else {
                            childId?.let {
                                val child: View = v.findViewById(it)
                                action.perform(uiController, child)
                            }
                        }
                    }
                }
            }
        }
    }
}