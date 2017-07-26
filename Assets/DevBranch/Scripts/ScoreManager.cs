using System.Collections;
using System.Collections.Generic;

using UnityEngine;
using UnityEngine.UI;

public class ScoreManager: Photon.PunBehaviour {

    #region Private Variables
    
    //private GameObject hill;

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

    #endregion

    #region MonoBehaviour CallBacks
    /// <summary>
    /// Use this for initialization
    /// </summary>
    void Start()
    {
        //hill = GameObject.Find("Hill (0)");
    }

    
    /// <summary>
    /// Update is called once per frame
    /// </summary>
    void Update()
    {

    }

    #endregion

    #region Public Methods
    
    /*
    /// <summary>
    /// Score update for specific team
    /// </summary>
    /// <param name="teamName"></param>
    [PunRPC]
    public void ScoreUpdate(string teamName)
    {
        if (teamName == teamRobotName)
        {
            if (robotsScore >= scoreLimit)
            {
                Win(teamRobotName);
                return;
            }

            InvokeRepeating("ScoreRobotsUp", 0.0f, 5.0f);
        }
        else if (teamName == teamZombieName)
        {
            if (zombiesScore >= scoreLimit)
            {
                Win(teamZombieName);
                return;
            }

            InvokeRepeating("ScoreZombiesUp", 0.0f, 5.0f);
        }
    }*/

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
                GOs[i].transform.Find("Message").GetComponent<Text>().text = "Robot team wins!";
            }

            Debug.Log("Robot team wins!");
        }
        else if (teamName == teamZombieName)
        {
            GameObject[] GOs = GameObject.FindGameObjectsWithTag("UI");
            for (int i = 0; i < GOs.Length; i++)
            {
                GOs[i].transform.Find("Message").GetComponent<Text>().text = "Zombie team wins!";
            }

            Debug.Log("Zombie team wins!");
        }
    }
    
    /*
    [PunRPC]
    protected IEnumerator ScoreUpdate(string teamName, float timeRepeat)
    {
        if (teamName == teamRobotName)
        {
            if (robotsScore >= scoreLimit)
            {
                Win(teamRobotName);
            }

            robotsScore += 10;

            GameObject[] GOs = GameObject.FindGameObjectsWithTag("UI");
            for (int i = 0; i < GOs.Length; i++)
            {
                GOs[i].transform.Find("Message").GetComponent<Text>().text = "Robots on hill!";
                GOs[i].transform.Find("ScoreRobots").GetComponent<Text>().text = robotsScore.ToString();
            }

            yield return new WaitForSeconds(timeRepeat);
        }
        else if (teamName == teamZombieName)
        {
            if (zombiesScore >= scoreLimit)
            {
                Win(teamZombieName);
            }

            zombiesScore += 10;

            GameObject[] GOs = GameObject.FindGameObjectsWithTag("UI");
            for (int i = 0; i < GOs.Length; i++)
            {
                GOs[i].transform.Find("Message").GetComponent<Text>().text = "Zombies on hill!";
                GOs[i].transform.Find("ScoreRobots").GetComponent<Text>().text = zombiesScore.ToString();
            }

            yield return new WaitForSeconds(timeRepeat);
        }
    }
    */

    [PunRPC]
    public void ScoreRobotsUpdate()
    {
        if (robotsScore >= scoreLimit)
        {
            Win(teamRobotName);
            return;
        }

        robotsScore += 10;

        GameObject[] GOs = GameObject.FindGameObjectsWithTag("UI");
        for (int i = 0; i < GOs.Length; i++)
        {
            GOs[i].transform.Find("Message").GetComponent<Text>().text = "Robots on hill!";
            GOs[i].transform.Find("ScoreRobots").GetComponent<Text>().text = robotsScore.ToString();
        }
    }

    [PunRPC]
    public void ScoreZombiesUpdate()
    {
        if (zombiesScore >= scoreLimit)
        {
            Win(teamZombieName);
            return;
        }

        zombiesScore += 10;

        GameObject[] GOs = GameObject.FindGameObjectsWithTag("UI");
        for (int i = 0; i < GOs.Length; i++)
        {
            GOs[i].transform.Find("Message").GetComponent<Text>().text = "Zombies on hill!";
            GOs[i].transform.Find("ScoreRobots").GetComponent<Text>().text = zombiesScore.ToString();
        }
    }

    #endregion
}
