using UnityEngine;
using System.Collections;
using NetBase;

public class Bullet : MonoBehaviour
{
    public AudioClip hitSolidSound;
    public AudioClip hitSoftSound;

    public AudioClip critHead;
    public AudioClip critHelmet;
    public AudioClip headshotVoice;

    void Start()
    {
        // Add velocity to the bullet
        GetComponent<Rigidbody>().velocity = transform.forward * 12;
        // Destroy the bullet after 1 second
        Destroy(this.gameObject, 1.0f);
    }

    void OnCollisionEnter(Collision collision)
    {
        var hit = collision.gameObject;

        // Very stupid check to see if we're hitting a gun
        if (hit.GetComponent<Gun>() != null)
        {
            return;
        }

        Destroy(gameObject);

        if (PhotonNetwork.isMasterClient)
        {
            NetworkAudio.SendPlayClipAtPoint(hitSolidSound, transform.position, 1.0f);
        }
    }

    /// <summary>
    /// When Bullet collides with players
    /// </summary>
    /// <param name="other"></param>
    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "RobotHead" || other.tag == "ZombieHead")
        {
            NetworkAudio.SendPlayClipAtPoint(hitSoftSound, transform.position, 1.0f);
            Debug.Log("Headshot");
        }
    }
}
