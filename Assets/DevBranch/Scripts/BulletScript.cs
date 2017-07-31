using System.Collections;
using System.Collections.Generic;

using UnityEngine;

namespace Com.VadimUnityDev.Robots_vs_Zombies_VR
{
  public class BulletScript : MonoBehaviour
  {

    //public GameObject player;
    private GameObject UI;

    // Use this for initialization
    void Start()
    {
      UI = GameObject.Find("UI");
    }

    // Update is called once per frame
    void Update()
    {

    }

    private void OnCollisionEnter(Collision collision)
    {
      //if (player.transform.position.z >= 4.5f)
      //{
      if (collision.gameObject.tag == "Target")
      {
        //UI.GetComponent<ScoreManager>().ScoreUpdate();
      }
      //}
    }

    //Suicide
    //private void OnTriggerEnter(Collider collider)
    //{
    //    if (collider.gameObject.tag == "VRCamera" || collider.gameObject.tag == "MainCamera")
    //    {
    //        Debug.Log("Suicide!");
    //        Time.timeScale = 0;
    //    }
    //}
  }
}
