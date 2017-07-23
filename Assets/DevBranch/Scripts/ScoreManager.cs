using System.Collections;
using System.Collections.Generic;

using UnityEngine;
using UnityEngine.UI;

public class ScoreManager: Photon.PunBehaviour {

    #region Private Variables

    private int robotsScore = 0;
    private int zombiesScore = 0;

    private int scoreLimit = 1000;

    private static string teamRobotName = "TeamRobot";
    private static string teamZombieName = "TeamZombie";

    #endregion

    #region Public Variables

    public Text scoreText;

    #endregion

    #region MonoBehaviour CallBacks
    /// <summary>
    /// Use this for initialization
    /// </summary>
    void Start()
    {
        scoreText = GameObject.Find("ScoreText").GetComponent<Text>();
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
            scoreText.text = robotsScore.ToString();
        }
        else if (teamName == teamZombieName)
        {
            if (robotsScore >= scoreLimit)
            {
                Win(teamZombieName);
                return;
            }

            zombiesScore ++;
            scoreText.text = zombiesScore.ToString();
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
            Debug.Log("Team Robot wins!");
        }
        else if (teamName == teamZombieName)
        {
            Debug.Log("Team Zombie wins!");
        }
    }

    #endregion
}
