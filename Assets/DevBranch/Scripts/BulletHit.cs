using System.Collections;
using System.Collections.Generic;

using UnityEngine;
using UnityEngine.UI;

namespace Com.VadimUnityDev.Robots_vs_Zombies_VR
{
  public class BulletHit : PlayerGeneralScript
  {

    /// <summary>
    /// Use this for initialization
    /// </summary>
    /*void Start()
    {

    }*/

    /// <summary>
    /// Update is called once per frame
    /// </summary>
    /*void Update()
    {

    }*/

    /// <summary>
    /// Method which invokes when bullet hits a player head
    /// </summary>
    /// <param name="other"></param>
    private void OnTriggerEnter(Collider other)
    {
      if (other.gameObject.tag == "Bullet")
      {
        health -= 55; //(int)Random.Range(30.0f, 70.0f)
        gameObject.transform.Find("CanvasPlayerHealth/HealthGroup/TextHealth").GetComponent<Text>().text = health.ToString();
        if (health <= 0)
        {
          gameObject.transform.Find("CanvasPlayerHealth/HealthGroup/TextHealth").GetComponent<Text>().text = "0";
          //Death(transform.parent.gameObject.name);
        }
      }
    }
  }
}
