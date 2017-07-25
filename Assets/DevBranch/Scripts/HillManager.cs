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

    private bool isCouroutineStarted;
    private bool isCouroutineEnded;
    private bool isHillEmpty = false; ///////////////////////////////// Temporary False, should be True
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
        
        messageTextObject.SetActive(false);

        InvokeRepeating("HillTeleport", 5.0f, 5.0f);
    }

    /// <summary>
    /// Update is called once per frame
    /// </summary>
    void Update()
    {
        ScoreUp();
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
    /// Method which invokes when enters in depend on player team
    /// </summary>
    /// <param name="headTag"></param>
    private void PlayerEnterHill(string headTag)
    {
        isHillEmpty = false;

        if (headTag == headRobotTag)
        {
            
        }
        else if (headTag == headZombieTag)
        {
            
        }

    }

    /// <summary>
    /// Method which invokes while staying in depend on player team
    /// </summary>
    /// <param name="headTag"></param>
    private void PlayerStayingHill(string headTag)
    {
        isHillEmpty = false;

        if (headTag == headRobotTag)
        {
            isRobotInside = true;
            messageText.text = robotsName + " on hill!";

            ScoreUpdate(teamRobotTag);
        }
        else if (headTag == headZombieTag)
        {
            isZombieInside = true;

            messageText.text = zombiesName + " on hill!";

            ScoreUpdate(teamZombieTag);
        }
        else if (isRobotInside && isZombieInside)
        {
            messageText.text = "Duel!";
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
    /// Method which invokes when exited in depend on player team
    /// </summary>
    /// <param name="headTag"></param>
    private void PlayerExitHill(string headTag)
    {
        isHillEmpty = true;
        
        if (headTag == headRobotTag)
        {
            isRobotInside = false;

            
        }
        else if (headTag == headZombieTag)
        {
            isZombieInside = false;

            
        }
    }

    /// <summary>
    /// Only if hill is captured by someone, score UPs
    /// </summary>
    private void ScoreUp()
    {
        /*if (true)
        {
            if (currentScore < scoreToWin)
            {
                currentScore++;
                if (currentScore % 100 == 0)
                {
                    hillScoreText.text = currentScore.ToString() + " / 1000";
                }
            }
            else if (currentScore == scoreToWin)
            {
                if (!isCouroutineStarted)
                {
                    StartCoroutine(TemporarilyActivateWin(5.0f));
                }
                if (isCouroutineEnded)
                {
                    return;
                }
            }
        }*/
    }

    /// <summary>
    /// Method which changes Hill position (only if hill is empty)
    /// </summary>
    private void HillTeleport()
    {
        if (isHillEmpty)
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

    #region IEnumerator Methods

    private IEnumerator TemporarilyActivateCaptured(float duration, string teamTag)
    {
        messageTextObject.SetActive(true);

        if (teamTag == teamRobotTag)
        {
            messageText.text = "Hill is captured by " + robotsName + "!";
        }
        else if (teamTag == teamZombieTag)
        {
            messageText.text = "Hill is captured by " + zombiesName + "!";
        }

        yield return new WaitForSeconds(duration);
        messageTextObject.SetActive(false);
    }

    private IEnumerator TemporarilyActivateWin(float duration, string teamName)
    {
        isCouroutineEnded = false;
        isCouroutineStarted = true;
        messageTextObject.SetActive(true);
        messageText.text = "You won!";
        yield return new WaitForSeconds(duration);
        messageTextObject.SetActive(false);
        isCouroutineEnded = true;
    }

    #endregion
}