using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PlayerManager : Photon.PunBehaviour {
    public GameObject[] spawns;

    [Tooltip("Reference to the player Robot avatar prefab")]
    public GameObject playerRobotAvatar;

    [Tooltip("Reference to the player Zombie avatar prefab")]
    public GameObject playerZombieAvatar;

    public List<PhotonPlayer> MyPlayers = new List<PhotonPlayer>(); // list customnih pleer  controllerov shtobi mojno bilo naiti index

    public delegate void OnCharacterInstantiated(GameObject character);

    public static event OnCharacterInstantiated CharacterInstantiated;

    void Awake() {
        if (playerRobotAvatar == null || playerZombieAvatar == null) {
            Debug.LogError("MyNetworkManager is missing a reference to the player avatar prefab!");
        }
    }

    public override void OnJoinedRoom()
    {
        //Debug.Log("[PlayerManager] OnJoinedRoom ");

        if (PhotonNetwork.isMasterClient)
        {
            NewPlayer(0);
        }
    }

    public override void OnPhotonPlayerConnected(PhotonPlayer newPlayer)
    {
        if (PhotonNetwork.isMasterClient)
        {
            var idx = PhotonNetwork.otherPlayers.Length;
            photonView.RPC("NewPlayer", newPlayer, idx);
        }
    }

    [PunRPC]
    void NewPlayer(int idx)
    {
        // Create a new player at the appropriate spawn spot
        var count = PhotonNetwork.room.playerCount;
        var trans = spawns[idx].transform;


        // Robots and zombies will spawn one after another
        if (count % 2 != 0)
        {
            var player = PhotonNetwork.Instantiate(playerRobotAvatar.name, trans.position, trans.rotation, 0);

            //photonView.RPC("SetName", PhotonTargets.All,  new object[] { "PlayerRobot " + idx.ToString(), idx });

            player.name = "PlayerRobot " + (idx + 1);
            //player.tag = "TeamRobot";
        }
        else
        {
            var player = PhotonNetwork.Instantiate(playerZombieAvatar.name, trans.position, trans.rotation, 0);

            player.name = "PlayerZombie " + (idx + 1);
            //player.tag = "TeamZombie";
        }

    }

    /*[PunRPC]
    public void SetTag(object [] parameters)
    {
        var name = parameters[0];

        var ind = parameters[1];

        // var player = MyPlayers.Find(plr => plr.ID == ind); //  ishesh sredi massiva playera s nujnim indexom

      //  player.gameobject.name = name;

    }*/
}
