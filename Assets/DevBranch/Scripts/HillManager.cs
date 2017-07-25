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

    private int currentScore = 0;
    private int hillTeleportCounter = 1;
    private int scoreToWin = 1000;

    private float hillStandValue = 0.0f;
    private float hillStandMaxValue;

    private bool isCouroutineEnded = false;
    private bool isCouroutineStarted = false;
    private bool hillCanTeleport = false;/////////////////////////////////
    private bool capturedByRobots;
    private bool capturedByZombies;

    #endregion

    #region Public Variables

    public GameObject[] hillsPositions;
    public GameObject hillMessagesTextObject;
    public GameObject hillPoint;
    public GameObject scoreRobotsTextObject;
    public GameObject scoreZombiesTextObject;

    public Slider sliderHillCaptureSlider;
    public Text hillMessagesText;
    public Text hillScoreText;

    #endregion

    #region MonoBehaviour CallBacks

    /// <summary>
    /// Use this for initialization
    /// </summary>
    void Start()
    {
        hillStandMaxValue = sliderHillCaptureSlider.maxValue;
        
        hillMessagesTextObject.SetActive(false);

        InvokeRepeating("HillTeleport", 5.0f, 5.0f);
    }

    /// <summary>
    /// Update is called once per frame
    /// </summary>
    void Update()
    {
        ScoreUp();
    }

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

    #region Private Methods
    
    /// <summary>
    /// Method which invokes when enters in depend on player team
    /// </summary>
    /// <param name="headTag"></param>
    private void PlayerEnterHill(string headTag)
    {
        hillCanTeleport = false;

        if (headTag == "RobotHead")
        {
            Debug.Log("Robot entered!");
        }
        else if (headTag == "ZombieHead")
        {
            Debug.Log("Zombie entered!");
        }
    }

    /// <summary>
    /// Method which invokes while staying in depend on player team
    /// </summary>
    /// <param name="headTag"></param>
    private void PlayerStayingHill(string headTag)
    {
        if (headTag == "RobotHead")
        {
            Debug.Log("Robot staying!");
        }
        else if (headTag == "ZombieHead")
        {
            Debug.Log("Zombie staying!");
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
        //    sliderHillCaptureSlider.value = hillStandValue;
        //    if (hillStandValue == hillStandMaxValue)
        //    {
        //        gameObject.GetComponent<Renderer>().material.SetColor("_TintColor", Color.green);
        //        hillPoint.GetComponent<Renderer>().material.SetColor("_TintColor", Color.green);

        //        isHillCaptured = true;
        //        sliderCaptureSlider.SetActive(false);
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
        hillCanTeleport = true;

        if (hillStandValue != hillStandMaxValue)
        {
            hillStandValue = 0.0f;
        }

        if (headTag == "RobotHead")
        {
            Debug.Log("Robot exited!");
        }
        else if (headTag == "ZombieHead")
        {
            Debug.Log("Zombie exited!");
        }
    }

    /// <summary>
    /// Only if hill is captured by someone, score UPs
    /// </summary>
    private void ScoreUp()
    {
        if (true/*                                                       */)
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
        }
    }

    /// <summary>
    /// Method which changes Hill position (only if hill is empty)
    /// </summary>
    private void HillTeleport()
    {
        if (hillCanTeleport)
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

    private IEnumerator TemporarilyActivateCaptured(float duration)
    {
        hillMessagesTextObject.SetActive(true);
        hillMessagesText.text = "Hill captured!";
        yield return new WaitForSeconds(duration);
        hillMessagesTextObject.SetActive(false);
    }

    private IEnumerator TemporarilyActivateWin(float duration)
    {
        isCouroutineEnded = false;
        isCouroutineStarted = true;
        hillMessagesTextObject.SetActive(true);
        hillMessagesText.text = "You won!";
        yield return new WaitForSeconds(duration);
        hillMessagesTextObject.SetActive(false);
        isCouroutineEnded = true;
    }

    #endregion
}