using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace Com.VadimUnityDev.Robots_vs_Zombies_VR
{
  public abstract class PlayerGeneralScript : ScoreManager
  {
    #region Private Variables

    private bool isRespawned;

    private int respawnTime = 3;
    //private Vector3 startPosition;

    //private Vector3 startRotation;


    #endregion

    #region Protected Variables

    [Tooltip("Health value of current player")]
    protected int health = 100;

    [Tooltip("Name of current player in hierarchy")]
    protected string playerName;

    [Tooltip("Team tag of current player")]
    protected string teamTag;

    [Tooltip("Head tag of current player")]
    protected string headTag;

    public GameObject[] hillsPositions;

    public GameObject[] playerSpawns;

    #endregion

    #region Private Methods

    private void Start()
    {
      // FIX IT
      /*startPosition = GameObject.Find("[CameraRig]").transform.position;
      Debug.Log(startPosition.ToString());
      startRotation = GameObject.Find("[CameraRig]").transform.eulerAngles;
      Debug.Log(startRotation.ToString());*/
    }

    private void Update()
    {

    }

    #endregion

    #region Public Methods

    /// <summary>
    /// Method which will set tag of player, and his head (which will collide)
    /// </summary>
    /// <param name="newTag"></param>
    /// <param name="newHeadTag"></param>
    [PunRPC]
    public virtual void SetTags(string newTag, string newHeadTag)
    {
      this.tag = newTag;
      gameObject.transform.Find("Head").tag = newHeadTag;
    }

    /// <summary>
    /// Method which will set name of player object
    /// </summary>
    /// <param name="newName"></param>
    [PunRPC]
    public virtual void SetName(string newName)
    {
      this.name = newName + GameObject.FindGameObjectsWithTag(tag).Length.ToString();
    }

    /// <summary>
    /// Method which will invoke when player health reaches zero
    /// </summary>
    [PunRPC]
    public virtual void Death(GameObject playerHead) //string playerName
    {
      isRespawned = false;
      GameObject.Find("[CameraRig]").transform.position = GameObject.Find("CameraSky").transform.position;
      GameObject.Find("[CameraRig]").transform.rotation = GameObject.Find("CameraSky").transform.rotation;

      ToggleHUD(playerHead, true);
      StartCoroutine(RespawnStart(playerHead, 1.0f));
    }

    /// <summary>
    /// Method which will spawn player after death
    /// </summary>
    [PunRPC]
    public virtual void Respawn(GameObject playerHead)
    {
      health = 100;
      ToggleHUD(playerHead, false);
      switch (playerHead.transform.parent.gameObject.name)
      {
        case "PlayerRobot 1":
          GameObject.Find("[VRTK]").transform.Find("SDKSetups/SteamVR/[CameraRig]").transform.position = playerSpawns[0].transform.position;
          GameObject.Find("[VRTK]").transform.Find("SDKSetups/SteamVR/[CameraRig]").transform.rotation = playerSpawns[0].transform.rotation;

          /*playerHead.transform.parent.position = playerSpawns[0].transform.position;
          playerHead.transform.parent.rotation = playerSpawns[0].transform.rotation;*/
          break;
        case "PlayerZombie 1":
          Debug.Log("Cake");
          GameObject.Find("[VRTK]").transform.Find("SDKSetups/SteamVR/[CameraRig]").transform.position = playerSpawns[1].transform.position;
          GameObject.Find("[VRTK]").transform.Find("SDKSetups/SteamVR/[CameraRig]").transform.rotation = playerSpawns[1].transform.rotation;

          /*playerHead.transform.parent.position = playerSpawns[1].transform.position;
          playerHead.transform.parent.rotation = playerSpawns[1].transform.rotation;*/
          break;
        case "PlayerRobot 2":
          playerHead.transform.parent.position = playerSpawns[2].transform.position;
          playerHead.transform.rotation = playerSpawns[2].transform.rotation;
          break;
        case "PlayerZombie 2":
          playerHead.transform.position = playerSpawns[3].transform.position;
          playerHead.transform.rotation = playerSpawns[3].transform.rotation;
          break;
        case "PlayerRobot 3":
          playerHead.transform.position = playerSpawns[4].transform.position;
          playerHead.transform.rotation = playerSpawns[4].transform.rotation;
          break;
        case "PlayerZombie 3":
          playerHead.transform.position = playerSpawns[5].transform.position;
          playerHead.transform.rotation = playerSpawns[5].transform.rotation;
          break;
        case "PlayerRobot 4":
          playerHead.transform.position = playerSpawns[6].transform.position;
          playerHead.transform.rotation = playerSpawns[6].transform.rotation;
          break;
        case "PlayerZombie 4":
          playerHead.transform.position = playerSpawns[7].transform.position;
          playerHead.transform.rotation = playerSpawns[7].transform.rotation;
          break;
        default:
          Debug.Log("Unknown player!");
          break;
      }
      //GameObject.Find("[VRTK]").transform.Find("SDKSetups/SteamVR/[CameraRig]").transform.position = startPosition;
      //GameObject.Find("[VRTK]").transform.Find("SDKSetups/SteamVR/[CameraRig]").transform.eulerAngles = startRotation;
      //GameObject.Find("[CameraRig]").transform.rotation = startPosition.rotation;
      Debug.Log("Respawn!");
    }

    /// <summary>
    /// Sets the HUD for player
    /// </summary>
    [PunRPC]
    public virtual void SetHUD()
    {
      GameObject go = Instantiate(Resources.Load("CanvasPlayer") as GameObject, gameObject.transform.Find("Head"));
      go.transform.localPosition = new Vector3(0.03f, 1.010859f, 2.958178f);
      gameObject.transform.Find("Head/CanvasPlayerHealth/HealthGroup/TextHealth").GetComponent<Text>().text = health.ToString();
      gameObject.transform.Find("Head/CanvasPlayerDead").gameObject.SetActive(false);
      /*gameObject.transform.Find("Head/CanvasPlayerDead/DeathGroup/TextDead").gameObject.SetActive(false);
      gameObject.transform.Find("Head/CanvasPlayerDead/DeathGroup/TextRespawn").gameObject.SetActive(false);*/
    }

    /// <summary>
    /// Toggles Death and Live HUDs
    /// </summary>
    /// <param name="playerHead"></param>
    /// <param name="isDead"></param>
    [PunRPC]
    private void ToggleHUD(GameObject playerHead, bool isDead)
    {
      if (isDead)
      {
        playerHead.GetComponent<MeshRenderer>().enabled = false;
        playerHead.transform.Find("Visor").GetComponent<MeshRenderer>().enabled = false;
        //playerHead.transform.parent.transform.localScale = new Vector3(0.0f,0.0f,0.0f);

        /*playerHead.transform.parent.transform.position = GameObject.Find("DeathSpawn (1)").transform.position;
        GameObject.Find("[VRTK]").transform.position = GameObject.Find("DeathSpawn (1)").transform.position;*/

        playerHead.transform.Find("CanvasPlayer(Clone)").gameObject.SetActive(false);
        playerHead.transform.Find("CanvasPlayerHealth").gameObject.SetActive(false);
        GameObject.Find("[VRTK]").transform.Find("SDKSetups/SteamVR/[CameraRig]/Controller (left)").gameObject.SetActive(false);
        GameObject.Find("[VRTK]").transform.Find("SDKSetups/SteamVR/[CameraRig]/Controller (right)").gameObject.SetActive(false);

        playerHead.transform.Find("CanvasPlayerDead").gameObject.SetActive(true);

        Debug.Log(playerHead.transform.parent.gameObject.name + " is Dead!");
      }
      else
      {
        playerHead.GetComponent<MeshRenderer>().enabled = true;
        playerHead.transform.Find("Visor").GetComponent<MeshRenderer>().enabled = true;
        //playerHead.transform.parent.transform.localScale = new Vector3(0.0f,0.0f,0.0f);

        /*playerHead.transform.parent.transform.position = GameObject.Find("DeathSpawn (1)").transform.position;
        GameObject.Find("[VRTK]").transform.position = GameObject.Find("DeathSpawn (1)").transform.position;*/

        playerHead.transform.Find("CanvasPlayer(Clone)").gameObject.SetActive(true);
        playerHead.transform.Find("CanvasPlayerHealth").gameObject.SetActive(true);
        playerHead.transform.Find("CanvasPlayerHealth/HealthGroup/TextHealth").GetComponent<Text>().text = health.ToString();
        GameObject.Find("[VRTK]").transform.Find("SDKSetups/SteamVR/[CameraRig]/Controller (left)").gameObject.SetActive(true);
        GameObject.Find("[VRTK]").transform.Find("SDKSetups/SteamVR/[CameraRig]/Controller (right)").gameObject.SetActive(true);

        playerHead.transform.Find("CanvasPlayerDead").gameObject.SetActive(false);

        Debug.Log(playerHead.transform.parent.gameObject.name + " is Alive!");
      }
    }

    /// <summary>
    /// Couroutine which invokes when player is dead
    /// </summary>
    /// <param name="playerHead"></param>
    /// <param name="repeatTime"></param>
    /// <returns></returns>
    private IEnumerator RespawnStart(GameObject playerHead, float repeatTime)
    {
      while (!isRespawned)
      {
        if (!isRespawned)
        {
          if (respawnTime == 0)
          {
            Respawn(playerHead);
            isRespawned = true;
            respawnTime = 4;
          }

          playerHead.transform.Find("CanvasPlayerDead/DeathGroup/TextRespawn").GetComponent<Text>().text = "Respawn: " + respawnTime;
          respawnTime--;

          yield return new WaitForSeconds(repeatTime);
        }
      }
    }

    #endregion
  }
}