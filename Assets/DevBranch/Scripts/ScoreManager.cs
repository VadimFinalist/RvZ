using System.Collections;
using System.Collections.Generic;

using UnityEngine;
using UnityEngine.UI;

public class ScoreManager: Photon.PunBehaviour {

    #region Private Variables

    private static string teamRobotName = "TeamRobot";
    private static string teamZombieName = "TeamZombie";

    #endregion

    #region Protected Variables
    
    [Tooltip("Score of Robot Team")]
    protected int robotsScore = 0;

    [Tooltip("Score of Zombie Team")]
    protected int zombiesScore = 0;

    [Tooltip("Slider value of Robot Team")]
    protected int sliderRobotsVal = 0;

    [Tooltip("Slider value of Zombie Team")]
    protected int sliderZombiesVal = 0;

    [Tooltip("Score limit which will grant Victory")]
    protected int scoreLimit;

    [Tooltip("Determines if scores started to udate")]
    protected bool scoringBegan;

    [Tooltip("Upper message content")]
    protected string message;

    #endregion

    #region Public Variables

    public Texture2D _purpleTex;
    public Texture2D _blueTex;
    public Texture2D _greenTex;

    #endregion

    #region MonoBehaviour CallBacks
    /// <summary>
    /// Use this for initialization
    /// </summary>
    void Start()
    {

    }

    
    /// <summary>
    /// Update is called once per frame
    /// </summary>
    void Update()
    {

    }

    #endregion

    #region Public Methods

    /// <summary>
    /// Win method for both teams
    /// </summary>
    /// <param name="teamName"></param>
    [PunRPC]
    public void Win(string teamName)
    {
        Time.timeScale = 0.0f;

        if (teamName == teamRobotName)
        {
            GameObject[] GOs = GameObject.FindGameObjectsWithTag("UI");
            for (int i = 0; i < GOs.Length; i++)
            {
                message = "Robot team wins!";
                GOs[i].transform.Find("Message").GetComponent<Text>().text = message;
            }
        }
        else if (teamName == teamZombieName)
        {
            GameObject[] GOs = GameObject.FindGameObjectsWithTag("UI");
            for (int i = 0; i < GOs.Length; i++)
            {
                message = "Zombie team wins!";
                GOs[i].transform.Find("Message").GetComponent<Text>().text = message;
            }
        }
    }

    /// <summary>
    /// Robots capturing behaviour
    /// </summary>
    [PunRPC]
    public void RobotsCapture()
    {
        if (sliderRobotsVal >= scoreLimit)
        {
            CancelInvoke("RobotsCapture");

            if (!scoringBegan)
            {
                GameObject.Find("Hill").GetComponent<Renderer>().material.SetTexture("_MainTex", _blueTex);
                InvokeRepeating("ScoreRobotsUpdate", 0.0f, 1.0f);
            }
        }
        else if (sliderZombiesVal > 0)
        {
            sliderZombiesVal--;

            GameObject[] GOs = GameObject.FindGameObjectsWithTag("UI");
            for (int i = 0; i < GOs.Length; i++)
            {
                GOs[i].transform.Find("SliderCapture").GetComponent<Slider>().value = sliderZombiesVal;
            }
        }
        else
        {
            GameObject.Find("Hill").GetComponent<Renderer>().material.SetTexture("_MainTex", _purpleTex);
            CancelInvoke("ScoreZombiesUpdate");
            scoringBegan = false;
            sliderRobotsVal++;

            GameObject[] GOs = GameObject.FindGameObjectsWithTag("UI");
            for (int i = 0; i < GOs.Length; i++)
            {
                if (sliderZombiesVal == 0)
                {
                    GOs[i].transform.Find("SliderCapture").GetComponent<Slider>().SetDirection(Slider.Direction.LeftToRight, true);
                    GOs[i].transform.Find("SliderCapture").transform.Find("Fill Area/Fill").GetComponent<Image>().color = new Color32(64, 97, 255, 255);
                    GOs[i].transform.Find("SliderCapture").GetComponent<Slider>().value = sliderRobotsVal;
                }
            }
        }
    }

    /// <summary>
    /// Zombies capturing behaviour
    /// </summary>
    [PunRPC]
    public void ZombiesCapture()
    {
        if (sliderZombiesVal >= scoreLimit)
        {
            CancelInvoke("ZombiesCapture");

            if (!scoringBegan)
            {
                GameObject.Find("Hill").GetComponent<Renderer>().material.SetTexture("_MainTex", _greenTex);
                InvokeRepeating("ScoreZombiesUpdate", 0.0f, 1.0f);
            }
        }
        else if (sliderRobotsVal > 0)
        {
            sliderRobotsVal--;

            GameObject[] GOs = GameObject.FindGameObjectsWithTag("UI");
            for (int i = 0; i < GOs.Length; i++)
            {
                GOs[i].transform.Find("SliderCapture").GetComponent<Slider>().value = sliderRobotsVal;
            }
        }
        else
        {
            GameObject.Find("Hill").GetComponent<Renderer>().material.SetTexture("_MainTex", _purpleTex);
            CancelInvoke("ScoreRobotsUpdate");
            scoringBegan = false;
            sliderZombiesVal++;

            GameObject[] GOs = GameObject.FindGameObjectsWithTag("UI");
            for (int i = 0; i < GOs.Length; i++)
            {
                GOs[i].transform.Find("SliderCapture").GetComponent<Slider>().SetDirection(Slider.Direction.RightToLeft, true);
                GOs[i].transform.Find("SliderCapture").transform.Find("Fill Area/Fill").GetComponent<Image>().color = new Color32(64, 255, 97, 255);
                GOs[i].transform.Find("SliderCapture").GetComponent<Slider>().value = sliderZombiesVal;
            }
        }
    }

    /// <summary>
    /// Score update if Robots captured hill
    /// </summary>
    [PunRPC]
    public void ScoreRobotsUpdate()
    {
        if (robotsScore >= scoreLimit)
        {
            Win(teamRobotName);
            return;
        }

        scoringBegan = true;

        robotsScore += 10;

        GameObject[] GOs = GameObject.FindGameObjectsWithTag("UI");
        for (int i = 0; i < GOs.Length; i++)
        {
            message = "Robots captured hill!";
            GOs[i].transform.Find("Message").GetComponent<Text>().text = message;
            GOs[i].transform.Find("ScoreRobots").GetComponent<Text>().text = robotsScore.ToString();
        }
    }

    /// <summary>
    /// Score update if Zombies captured hill
    /// </summary>
    [PunRPC]
    public void ScoreZombiesUpdate()
    {
        if (zombiesScore >= scoreLimit)
        {
            Win(teamZombieName);
            return;
        }

        scoringBegan = true;

        zombiesScore += 10;

        GameObject[] GOs = GameObject.FindGameObjectsWithTag("UI");
        for (int i = 0; i < GOs.Length; i++)
        {
            message = "Zombies captured hill!";
            GOs[i].transform.Find("Message").GetComponent<Text>().text = message;
            GOs[i].transform.Find("ScoreZombies").GetComponent<Text>().text = zombiesScore.ToString();
        }
    }

    #endregion
}
