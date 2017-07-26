using System.Collections;
using System.Collections.Generic;

using UnityEngine;
using UnityEngine.UI;

public class HillManager : ScoreManager
{
    #region Private Variables

    private string headRobotTag = "RobotHead";
    private string headZombieTag = "ZombieHead";
    private string teamRobotTag = "TeamRobot";
    private string teamZombieTag = "TeamZombie";
    private string robotsName = "Robots";
    private string zombiesName = "Zombies";

    private int hillTeleportCounter = 1;
    private int _countInHill;

    private bool isCouroutineStarted;
    private bool isCouroutineEnded;
    private bool capturedByRobots;
    private bool capturedByZombies;
    private bool isRobotInside;
    private bool isZombieInside;

    #endregion

    #region Public Variables

    public GameObject[] hillsPositions;
    public GameObject hillPoint;
    public GameObject messageTextObject;
    public GameObject scoreRobotsTextObject;
    public GameObject scoreZombiesTextObject;

    public Slider captureSlider;
    public Text messageText;
    public Text scoreRobotsText;
    public Text scoreZombiesText;

    #endregion

    #region MonoBehaviour CallBacks

    /// <summary>
    /// Use this for initialization
    /// </summary>
    void Start()
    {
        scoreLimit = (int)captureSlider.maxValue;

        InvokeRepeating("HillTeleport", 5.0f, 5.0f);
    }

    /// <summary>
    /// Update is called once per frame
    /// </summary>
    void Update()
    {

    }

    #region Collision Methods

    /// <summary>
    /// Method which invokes when player enters an hill area
    /// </summary>
    /// <param name="other"></param>
    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.tag == headRobotTag)
        {
            PlayerEnterHill(headRobotTag);
        }
        else if (other.gameObject.tag == headZombieTag)
        {
            PlayerEnterHill(headZombieTag);
        }
    }

    /// <summary>
    /// Method which invokes when player (or both R an Z) staying inside Hill
    /// </summary>
    /// <param name="other"></param>
    private void OnTriggerStay(Collider other)
    {
        if (other.gameObject.tag == headRobotTag)
        {
            PlayerStayingHill(headRobotTag);
        }
        else if (other.gameObject.tag == headZombieTag)
        {
            PlayerStayingHill(headZombieTag);
        }
    }

    /// <summary>
    /// Method which invokes when player leaves the Hill
    /// </summary>
    /// <param name="other"></param>
    private void OnTriggerExit(Collider other)
    {
        if (other.gameObject.tag == headRobotTag)
        {
            PlayerExitHill(headRobotTag);
        }
        else if (other.gameObject.tag == headZombieTag)
        {
            PlayerExitHill(headZombieTag);
        }
    }

    #endregion

    #endregion

    #region Private Methods

    /// <summary>
    /// Method which invokes when enters hill in depend on player team
    /// </summary>
    /// <param name="headTag"></param>
    private void PlayerEnterHill(string headTag)
    {
        if (headTag == headRobotTag)
        {
            _countInHill++;
            InvokeRepeating("ScoreRobotsUpdate", 0.0f, 1.0f);
        }
        else if (headTag == headZombieTag)
        {
            _countInHill++;
            InvokeRepeating("ScoreZombiesUpdate", 0.0f, 1.0f);
        }

    }
    
    /// <summary>
    /// Method which invokes while staying hill in depend on player team
    /// </summary>
    /// <param name="headTag"></param>
    private void PlayerStayingHill(string headTag)
    {
        if (isRobotInside && isZombieInside)
        {
            GameObject[] GOs = GameObject.FindGameObjectsWithTag("UI");
            for (int i = 0; i < GOs.Length; i++)
            {
                GOs[i].transform.Find("Message").GetComponent<Text>().text = "Duel!";
            }

            CancelInvoke("ScoreRobotsUpdate");
            CancelInvoke("ScoreZombiesUpdate");
        }

        if (headTag == headRobotTag)
        {
            isRobotInside = true;

            //ScoreUpdate(teamRobotTag);

            /*GameObject[] GOs = GameObject.FindGameObjectsWithTag("UI");
            for (int i = 0; i < GOs.Length; i++)
            {
                GOs[i].transform.Find("ScoreRobots").GetComponent<Text>().text = robotsScore.ToString();
            }*/
        }
        else if (headTag == headZombieTag)
        {
            isZombieInside = true;

            //messageText.text = zombiesName + " on hill!";

            //ScoreUpdate(teamZombieTag);
            //InvokeRepeating("ScoreZombiesUp", 0.0f, 1.0f);

            /*GameObject[] GOs = GameObject.FindGameObjectsWithTag("UI");
            for (int i = 0; i < GOs.Length; i++)
            {
                GOs[i].transform.Find("Message").GetComponent<Text>().text = zombiesName + " on hill!";
                GOs[i].transform.Find("ScoreZombies").GetComponent<Text>().text = zombiesScore.ToString();
            }*/
        }




        //if (other.gameObject.tag == headRobotTag)
        //{
        //    if (hillStandValue == hillStandMaxValue)
        //    {
        //        return;
        //    }
        //    if (hillStandValue < hillStandMaxValue)
        //    {
        //        hillStandValue++;
        //        Debug.Log("Inside...");

        //        //Blinking
        //        //
        //        //if (Time.fixedTime % .5 < .2)
        //        //{
        //        //    GetComponent<Renderer>().enabled = false;
        //        //}
        //        //else
        //        //{
        //        //    GetComponent<Renderer>().enabled = true;
        //        //}
        //    }
        //    captureSlider.value = hillStandValue;
        //    if (hillStandValue == hillStandMaxValue)
        //    {
        //        gameObject.GetComponent<Renderer>().material.SetColor("_TintColor", Color.green);
        //        hillPoint.GetComponent<Renderer>().material.SetColor("_TintColor", Color.green);

        //        isHillCaptured = true;
        //        captureSlider.SetActive(false);
        //        hillScoreTextObject.SetActive(true);
        //        StartCoroutine(TemporarilyActivateCaptured(3.00f));

        //        Debug.Log("Captured!");
        //    }
        //}
        //else if (other.gameObject.tag == headZombieTag)
        //{

        //}
    }

    /// <summary>
    /// Method which invokes when exited hill in depend on player team
    /// </summary>
    /// <param name="headTag"></param>
    private void PlayerExitHill(string headTag)
    {
        if (headTag == headRobotTag)
        {
            isRobotInside = false;
            _countInHill--;

            if (_countInHill == 0)
            {
                CancelInvoke("ScoreRobotsUpdate");
            }
        }
        else if (headTag == headZombieTag)
        {
            isZombieInside = false;
            _countInHill--;

            if (_countInHill == 0)
            {
                CancelInvoke("ScoreZombiesUpdate");
            }
        }
    }

    /// <summary>
    /// Method which changes Hill position (only if hill is empty)
    /// </summary>
    private void HillTeleport()
    {
        if (_countInHill == -1) //Temporary, should be zero
        {
            if (hillTeleportCounter == hillsPositions.Length)
            {
                hillTeleportCounter = 0;
            }

            gameObject.transform.position = hillsPositions[hillTeleportCounter].transform.position;
            hillTeleportCounter++;
        }
    }

    #endregion
}