//This is a targetfps script. Copyrights © of PolyPixel3D

using UnityEngine;
using System.Collections;

public class FrameRateCap : MonoBehaviour {

    //Set targetfps variable
    public int TargetFPS = 60;

	// Use this for initialization
	void Start ()
    {
        //Sets target fps based of public int variable
        Application.targetFrameRate = TargetFPS;

    }
}