using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ScoreScript : MonoBehaviour {

    private int score = 0;

    private Text scoreText;

    // Use this for initialization
    void Start()
    {
        scoreText = GameObject.Find("ScoreText").GetComponent<Text>();
    }

    // Update is called once per frame
    void Update()
    {

    }

    public void ScoreUpdate()
    {
        score += 5;
        scoreText.text = score.ToString();
    }
}
