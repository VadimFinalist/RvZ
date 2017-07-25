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

            robotsScore ++;
        }
        else if (teamName == teamZombieName)
        {
            if (zombiesScore >= scoreLimit)
            {
                Win(teamZombieName);
                return;
            }

            zombiesScore ++;
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

    #endregion
}
