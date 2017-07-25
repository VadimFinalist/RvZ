using System.Collections;
using System.Collections.Generic;

using UnityEngine;
using UnityEngine.UI;

public class ScoreManager: Photon.PunBehaviour {

    #region Private Variables
    
    private GameObject hill;

    private static string teamRobotName = "TeamRobot";
    private static string teamZombieName = "TeamZombie";

    #endregion

    #region Public Variables
    
    [Tooltip("Score of Robot Team")]
    public int robotsScore = 0;

    [Tooltip("Score of Zombie Team")]
    public int zombiesScore = 0;

    [Tooltip("Score limit which will grant Victory")]
    public int scoreLimit;

    #endregion

    #region MonoBehaviour CallBacks
    /// <summary>
    /// Use this for initialization
    /// </summary>
    void Start()
    {
        hill = GameObject.Find("Hill (0)");
    }

    /* Update
    /// <summary>
    /// Update is called once per frame
    /// </summary>
    void Update()
    {

    }*/

    #endregion

    #region Public Methods

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
    }

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

            Debug.Log("Team Robot wins!");
        }
        else if (teamName == teamZombieName)
        {
            GameObject[] GOs = GameObject.FindGameObjectsWithTag("UI");
            for (int i = 0; i < GOs.Length; i++)
            {
                GOs[i].transform.Find("Message").GetComponent<Text>().text = "Zombie team wins!";
            }

            Debug.Log("Team Zombie wins!");
        }
    }

    /*[PunRPC]
    private IEnumerator ScoreUp(string teamName)
    {
        if (teamName == teamRobotName)
        {
            robotsScore += 1;
        }
        else if (teamName == teamZombieName)
        {
            zombiesScore += 1;
        }

        yield return new WaitForSeconds(1.0f);
    }*/

    [PunRPC]
    public void ScoreRobotsUp()
    {
        if (robotsScore >= scoreLimit)
        {
            Win(teamRobotName);
            return;
        }

        robotsScore += 10;
    }

    [PunRPC]
    public void ScoreZombiesUp()
    {
        if (zombiesScore >= scoreLimit)
        {
            Win(teamZombieName);
            return;
        }

        zombiesScore += 10;
    }

    #endregion
}
